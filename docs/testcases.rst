==================
Test and Use Cases
==================

It's not strict Gherkin, but makes sense anyway.

Pre-requisites:
* the customer is registered in the IDP
* the customer is registered in the DCL/DCP
* ledger has obtained an access token from the IDP, for the customer



eInvoicing endpoints management
-------------------------------

**Create an eInvoicing endpoint for the customer**

.. sourcecode:: gherkin

    Given I'm ledger with some client(s)
    And I want to receive messages for my client
    Then I send POST request to "/api/endpoints/" with parameters, identifying my client
    And in response I get unique identifier of an endpoint on which anyone could send TAP messages

    As a result I can:
    1) Define for which client the message has been received
    2) Consider that digital signature is already verified
    3) Consider that any correct message is notarized

    And gherkin one:

    Given I have valid JWT token
    When I send POST request on "/api/endpoints/" address with participant_id and metadata
    Then in response I get unique identifier of endpoint

**search endpoint**

.. sourcecode:: gherkin

    Given I'm ledger with a client
    And I want to find existing endpoints for my client
    Then I send GET request on "/api/endpoints/" with parameters, identifying my client
    And in response I get list of endpoints for my client on which anyone could send TAP messages

    Given I'm ledger with a client
    And I want to filter existing endpoints for my client by metadata
    Then I send GET request on "/api/endpoints/" with parameters, identifying my client and specific metadata
    And in response I get list of endpoints for my client filtered by sent metadata

    Given I have valid JWT token
    When I send GET request on "/api/endpoints/" address with parameters
    Then in response I get a list of endpoints

**get endpoint data**

.. sourcecode:: gherkin

    Given I'm ledger with a client
    And I want to get endpoint information for my client
    Then I send GET request on "/api/endpoints/{endpoint_id}/" with parameters, identifying my client and id of existing endpoint
    And in response I get data of specified endpoint

    Given I have valid JWT token and endpoint id
    When I send GET request on "/api/endpoints/{endpoint_id}/" address with parameters
    Then in response I get endpoint data

**update endpoint**

.. sourcecode:: gherkin

    Given I'm ledger with a client
    And I want to update endpoint information for my client
    Then I send PATCH request on "/api/endpoints/{endpoint_id}/" with parameters, identifying my client and id of existing endpoint and data to be updated
    And in response I get updated data of specified endpoint

    Given I have valid JWT token and endpoint id
    When I send PATCH request on "/api/endpoints/{endpoint_id}/" address with parameters to update
    Then in response I get updated endpoint data


Create and sign a message
-------------------------

The steps any message sender need to perform to enclose his message to some format, acceptable by TAP-GW due to TAP protocol

Requirements:

* sender have access to it's own private and public keys
* sender knows receiver participant id
* sender knows receiver public key (which can be retrieved by participant id and given DCL)
* sender have OpenPGP installation (gpg, gpg2, etc)
* sender have eInvoicing document (in any format, let's call it invoice.json, but it can be I-48834.pdf or whatever)

Steps:

1. Encrypt initial document and get ascii armored output, use receiver public key
2. compose TAP message.json file as described in spec and examples (TODO: spec, examples links)
3. Sign TAP message.json file with sender private key, get signature file (message.json.sig)
4. Make sure sender public key is published in DCP, DCP is published in DCL, and the key can be found by any party
5. Send message.json and message.json.sig to TAP endpoint or TAP-GW endpoint.


Example implementation: tap-message-composer script https://github.com/test-point/testpoint-tap/tree/master/tap-message-composer

Detailed explanation how to do it using GPG: (TODO: put link, we have it, but it's not published yet)

.. sourcecode:: gherkin

    Given I'm ledger with a client
    And I want to sign and encrypt message for my client
    And I have public key of receiver of that message
    And I have private key of my client
    Then I should format json message with following fields:
        "cyphertext" containing encrypted by GPG message using public key of receiver
        "hash" containing SHA256 hash of message (before encryption)
        "sender" containing unique participant identifier of my client
        "reference" containing additional information
    And signature of message made by private key of my client


Send a message to another participant
-------------------------------------

.. sourcecode:: gherkin

    Given I'm ledger with a client
    And I want to send message from my client to another participant
    And I have an endpoint_id of another participant receiving endpoint
    And I have signed and encrypted message
    Then I send POST request on "/api/endpoints/{endpoint_id}/message/" with:
      * parameters, identifying my client
      * id of existing endpoint of another participant (receiver)
      * json file containing encrypted message from my client (sender)
      * signature of encrypted message from my client (sender)
    And In response I get unique identifier of message
    And message is sent after some validation

Receive message from another participants
-----------------------------------------

.. sourcecode:: gherkin

    Given I'm ledger with a client
    And I want to get all the messages for my client
    Then I send GET request on "/api/messages/" with parameters, identifying my client
    And in response I get all messages sent to endpoints of my client

    Given I'm ledger with a client
    And I want to get messages for my client sent to specific endpoint
    Then I send GET request on "/api/messages/" with parameters, identifying my client and id of endpoint
    And In response I get all messages sent to given endpoint of my client
    Given I'm ledger with a client
    And I want to get messages with specific parameters for my client
    Then I send GET request on "/api/messages/" with parameters, identifying my client and specific parameters  of message
    And In response I get all messages sent to my client with specific parameters

    Given I'm ledger with a client
    And I want to mark message sent to my client as read
    Then I send PATCH request on "/api/messages/{message_id}/" with parameters, identifying my client and id of message and `"is_read": true` JSON parameter
    And in response I get updated metadata of message
    And as a result message is marked as read

Decrypt a message from another participant
------------------------------------------

This is an optional step, if you don't have private keys of your clients you just pass the cyphertext of the message to client's endpoints (in any way) and client decrypts it itself.

.. sourcecode:: gherkin

    Given I'm ledger with a client
    And I want to decrypt message sent from another participant for my client
    And I have private key of my client
    Then using docId from received message I can download json file from NRY
    And as a result I can decrypt message from "cyphertext" of json using private key and local GPG implementation/installation
