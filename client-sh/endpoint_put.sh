#!/bin/bash

curl -XPOST --header 'Content-Type: application/json' \
    --header "Authorization: ${TAP_AUTH}" \
    -d '{"participant_id": "urn:oasis:names:tc:ebcore:partyid-type:iso6523:0151::12349666202", "keyX": "value1"}' \
    'https://tap-gw.testpoint.io/api/endpoints/'
echo
