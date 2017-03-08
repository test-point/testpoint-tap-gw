==================
Test and Use Cases
==================

It's not strict Gherkin, but makes sense anyway.


Create an eInvoicing endpoint for the customer
----------------------------------------------

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


Example implementation: tap-message-composer script (TODO: put a link here, we have it, but it's not published yet)
Detailed explanation how to do it using GPG: (TODO: put link, we have it, but it's not published yet)
