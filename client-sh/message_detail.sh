#!/bin/bash

echo "OK, visible and available:"
curl "https://tap-gw.testpoint.io/api/messages/d3107860-98c6-446a-ac6b-1d94225ae9d5/" \
     --header "Authorization: ${TAP_AUTH}"
