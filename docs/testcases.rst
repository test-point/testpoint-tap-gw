==================
Test and Use Cases
==================

It's not strict Gherkin, but makes sense anyway.

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
