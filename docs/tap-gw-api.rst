========
REST API
========

API Overview
============

API root URL: http://tap-gw.testpoint.io/api/

Dates: ISO8601 with timezone

Format: jsonapi.org

Authorisation
=============

Authorisation is being performed by JWT token. JWT token value prepended by `JWT`, for example: `JWT XXXXX.YYYYYYYYYYYYYYYYYYYYYYY.ZZZZZZ` You can get your JWT for testpoint.io services at https://idp.testpoint.io/.

Endpoints
=========

TAP-GW endpoint is an object, which works for determining which participant ID shall receive given message. Ledger can create endpoints for given participant_id and metadata. Metadata is a list of key-value items of any format, where ledger can store his custom data and filter endpoints/messages by it.

Get endpoints list
------------------

* GET /api/endpoints/
* Only endpoints for the given user will be returned
* Filtering by metadata is supported (pass metadata and values to filter by as GET parameters)

**Request example: get all endpoints**:

.. sourcecode:: bash

    curl http://tap-gw.testpoint.io/api/endpoints/ \
        -H "Authorization: JWT XXXXX.YYYYYYYYYYYYYYYYYYYYYYY.ZZZZZZ"

**Request example: filter specific endpoints by metadata**:

* Only endpoints with metadata key1 equal to value1 and key2 equal to value2 will be returned.

.. sourcecode:: bash

    curl "http://tap-gw.testpoint.io/api/endpoints/?key1=value1&key2=value2" \
        -H "Authorization: JWT XXXXX.YYYYYYYYYYYYYYYYYYYYYYY.ZZZZZZ"


**Response example**:

.. sourcecode:: http

    HTTP/1.1 200 OK
    Content-Type: application/json
    Vary: Accept, Cookie
    Allow: GET, POST, OPTIONS

    {
        "links": {
            "first": "http://tap-gw.testpoint.io/api/endpoints/?page=1",
            "last": "http://tap-gw.testpoint.io/api/endpoints/?page=1",
            "next": null,
            "prev": null
        },
        "data": [
            {
                "type": "TapGwEndpoint",
                "id": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXXX",
                "attributes": {
                    "participant_id": "urn:oasis:names:tc:ebcore:partyid-type:iso6523:0151::9999999999",
                    "endpoint_type": "ausdigital-tap/2",
                    "key1": "value1",
                    "key2": "value2"
                }
            },
            ...
        ],
        "meta": {
            "pagination": {
                "page": 1,
                "pages": 1,
                "count": X
            }
        }
    }


**Responses**

* 200 OK
* 401 Authentication credentials were not provided
* 401 Invalid Authorization header. JWT Signature verification failed
* 500 Internal server error

Create endpoint
---------------

* POST /api/endpoints/

**Request payload**

JSON with desired endpoint fields is expected.

* participant_id: string, valid urn participant ID of end business, **required**
* key: string, any metadata value

**Request example**:

.. sourcecode:: json

    {
        "participant_id": "urn:oasis:names:tc:ebcore:partyid-type:iso6523:0151::9999999999",
        "key1": "value1",
        ...
        "keyN": "valueN"
    }

**Request example**:

.. sourcecode:: bash

    curl -XPOST "http://tap-gw.testpoint.io/api/endpoints/" \
        -H "Content-type: application/json" \
        -H "Authorization: JWT XXXXX.YYYYYYYYYYYYYYYYYYYYYYY.ZZZZZZ" \
        -d '{"participant_id": "urn:oasis:names:tc:ebcore:partyid-type:iso6523:0151::9999999999", "keyX": "valueeY"}'

**Response example**:

.. sourcecode:: http

    HTTP/1.1 201 Created
    Content-Type: application/json
    Vary: Accept, Cookie
    Allow: GET, POST, OPTIONS

    {
        "data": {
            "type": "TapGwEndpoint",
            "id": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXX",
            "attributes": {
                "participant_id": "urn:oasis:names:tc:ebcore:partyid-type:iso6523:0151::9999999999",
                "endpoint_type": "ausdigital-tap/2",
                "keyX": "valueeY"
            }
        }
    }

**Response codes**

* 201 Created
* 400 Bad request (JSON parse error, check response for details)
* 401 Authentication credentials were not provided.
* 401 Invalid Authorization header. JWT Signature verification failed.
* 500 Internal server error

Endpoint details
----------------

* GET /api/endpoints/{endpoint_id}/
* Only endpoints for the given user will be returned (user determined by JWT)

**Request example**:

.. sourcecode:: bash

    curl "http://tap-gw.testpoint.io/api/endpoints/{endpoint_id}/" \
        -H "Authorization: JWT XXXXX.YYYYYYYYYYYYYYYYYYYYYYY.ZZZZZZ"


**Response example**:

.. sourcecode:: http

    HTTP/1.1 200 OK
    Content-Type: application/json
    Vary: Accept, Cookie
    Allow: GET, OPTIONS

    {
        "data": {
            "type": "TapGwEndpoint",
            "id": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXX",
            "attributes": {
                "participant_id": "urn:oasis:names:tc:ebcore:partyid-type:iso6523:0151::9999999999",
                "endpoint_type": "ausdigital-tap/2",
                "keyX": "valueeY"
            }
        }
    }

**Responses**

* 200 OK
* 401 Authentication credentials were not provided.
* 401 Invalid Authorization header. JWT Signature verification failed.
* 404 Not Found
* 500 Internal server error

Endpoint update
---------------

* PUT /api/endpoints/{endpoint_id}/ -  to completely replace the whole metadata set
* PATCH /api/endpoints/{endpoint_id}/ - to update only passed set of keys/values
* Only endpoints for the given user could be updated
* To delete metadata item send PUT without key which shall be deleted
* New version of the object is returned, with metadata updated

**Request example**:

.. sourcecode:: bash

curl -XPUT "http://tap-gw.testpoint.io/api/endpoints/{endpoint_id}/" \
    -H "Content-type: application/json" \
    -H "Authorization: JWT XXXXX.YYYYYYYYYYYYYYYYYYYYYYY.ZZZZZZ" \
    -d '{"keyX": "ValueX"}'

.. sourcecode:: bash

curl -XPATCH "http://tap-gw.testpoint.io/api/endpoints/{endpoint_id}/" \
    -H "Content-type: application/json" \
    -H "Authorization: JWT XXXXX.YYYYYYYYYYYYYYYYYYYYYYY.ZZZZZZ" \
    -d '{"keyX": "ValueX"}'


**Response example**:

.. sourcecode:: http

    HTTP/1.1 200 OK
    Content-Type: application/json
    Vary: Accept, Cookie
    Allow: GET, PUT, PATCH, HEAD, OPTIONS

    {
        "data": {
            "type": "TapGwEndpoint",
            "id": "endpoint_id",
            "attributes": {
                "participant_id": "urn:oasis:names:tc:ebcore:partyid-type:iso6523:0151:9999999999",
                "endpoint_type": "ausdigital-tap/2",
                "keyX": "ValueX"
            }
        }
    }

**Responses**

* 200 OK
* 400 Bad request (check response for details)
* 401 Authentication credentials were not provided.
* 401 Invalid Authorization header. JWT Signature verification failed.
* 404 Not Found
* 500 Internal server error

Post TAP message
----------------

* POST /api/endpoints/{endpoint_id}/message/

**Request payload**

* Payload must be a TAP message with a signature:

  * request enctype: multipart/form-data
  * `message` file as a parameter
  * `signature` file as a parameter.

* {endpoint_id} should be guid of the endpoint. It may be received by endpoint owner from POST /api/endpoints/ or GET /api/endpoints/ methods, and endpoint owner may publish this value by any way, optionally after link proxy/anonymisation.
* Message validation and checking steps are performed. Some of them blocking (TAP-GW won't accept messages or signatures which look obviously wrong). Some of them are performed in background due to time-consuming nature (for example, signature validation). If background validation has failed then message receives 'error' status and some debug info MAY be provided (for example, 'Wrong digital signature').
* User MAY use specific endpoint to query message status (TODO: implement and document that endpoint), and react on 'error' status accordignly, and assume 'sent' status is good and final. Also, message UUID may be useful for debug purposes.


**Request example**:

.. sourcecode:: bash

    curl -XPOST "http://tap-gw.testpoint.io/api/endpoints/{endpoint_id}/message/" \
        -H "Content-type: multipart/form-data" \
        -F "message=@var/tapmessage.json" \
        -F "signature=@var/tapsignature.sig"

**Response example**:

.. sourcecode:: http

    HTTP/1.1 202 Accepted
    Content-Type: application/json
    Vary: Accept, Cookie
    Allow: POST, OPTIONS

    {
        "data": {
            "type": "TapMessage",
            "id": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXXX",
            "attributes": {
                "uuid": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXXX",
                "status": {"in_transit", "send"}
            }
        }
    }

**Response codes**

* 202 Accepted - message has been queued for validation and sending
* 400 No file was submitted.
* 404 Endpoint doesn't exist
* 415 Unsupported media type (it shall be multipart/form-data)
* 500 Internal server error

GET TAP messages
----------------

* GET /api/messages/
* Only messages from endpoints created by user with given JWT will be returned
* Filtering by metadata and parametres is supported (pass metadata and values to filter by as GET parameters)
* Following parametres are available for filtering: is_read, endpoint, participant_id
* Any other query parameter is filtered as 'exact' metadata of endpoint (returns only messages from endpoints which have metadata with given key equal to given value).

**Request example: get all messages**:

.. sourcecode:: bash

    curl "http://tap-gw.testpoint.io/api/messages/" \
        -H "Authorization: JWT XXXXX.YYYYYYYYYYYYYYYYYYYYYYY.ZZZZZZ"


**Request example: filter specific messages by parametres or metadata**:

* Only messages with metadata key1 equal to value1 and key2 equal to value2 will be returned.

.. sourcecode:: bash

    curl "http://tap-gw.testpoint.io/api/messages/?key1=value1&key2=value2" \
        -H "Authorization: JWT XXXXX.YYYYYYYYYYYYYYYYYYYYYYY.ZZZZZZ"


**Response example**:

.. sourcecode:: http

    HTTP/1.1 200 OK
    Content-Type: application/json
    Vary: Accept, Cookie
    Allow: GET, HEAD, OPTIONS

    {
        "links": {
            "first": "http://tap-gw.testpoint.io/api/messages/?page=1",
            "last": "http://tap-gw.testpoint.io/api/messages/?page=1",
            "next": null,
            "prev": null
        },
        "data": [
            {
                "type": "TapMessage",
                "id": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXX",
                "attributes": {
                    "uuid": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXX",
                    "status": "sent",
                    "created_at": "2017-02-27T05:52:27.618962Z",
                    "sent_at": "2017-02-27T05:52:46.081878Z",
                    "doc_id": "QmXXXXXXXXXXXXXXXXXXXXXXXXXXX",
                    "is_read": false,
                    "metadata": {
                        "key1": "value2",
                        "key2": "value2"
                    },
                    "endpoint": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXX"
                }
            },
            ...
        ],
        "meta": {
            "pagination": {
                "page": 1,
                "pages": 1,
                "count": X
            }
        }
    }

**Response codes**

* 200 OK
* 401 Authentication credentials were not provided.
* 401 Invalid Authorization header. JWT Signature verification failed.
* 401 Any other problem with JWT
* 500 Internal server error

Update TAP message
------------------

* PATCH /api/messages/{message_id}/
* Only messages for the given user could be updated
* Only is_read parameter of message could be updated

**Request example**:

.. sourcecode:: bash

  curl -XPATCH "http://tap-gw.testpoint.io/api/messages/{message_id}/" \
    -H "Content-type: application/json" \
    -H "Authorization: JWT XXXXX.YYYYYYYYYYYYYYYYYYYYYYY.ZZZZZZ" \
    -d '{"is_read": true}'

**Response example**:

.. sourcecode:: http

    HTTP/1.1 200 OK
    Content-Type: application/json
    Vary: Accept, Cookie
    Allow: GET, PUT, PATCH, HEAD, OPTIONS

    {
        "data": {
            "type": "TapMessage",
            "id": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXX",
            "attributes": {
                "uuid": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXX",
                "status": "sent",
                "created_at": "2017-02-27T05:52:27.618962Z",
                "sent_at": "2017-02-27T05:52:46.081878Z",
                "doc_id": "QmXXXXXXXXXXXXXXXXXXXXXXXXXXX",
                "is_read": true,
                "metadata": {
                    "key1": "value2",
                    "key2": "value2"
                },
                "endpoint": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXX"
            }
        }
    }

**Responses**

* 200 OK
* 400 Bad request (check response for details)
* 401 Authentication credentials were not provided.
* 401 Invalid Authorization header. JWT Signature verification failed.
* 404 Not Found
* 500 Internal server error
