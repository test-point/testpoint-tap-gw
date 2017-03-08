#!/bin/bash

echo "Visible, but unknown keyword:"
curl -XPATCH "https://tap-gw.testpoint.io/api/messages/d3107860-98c6-446a-ac6b-1d94225ae9d5/" \
     -d '{"unknown_new_keyword": "new_value"}' \
     --header "Authorization: ${TAP_AUTH}"

echo "Visible, but no payload:"
curl -XPATCH "https://tap-gw.testpoint.io/api/messages/d3107860-98c6-446a-ac6b-1d94225ae9d5/" \
     --header "Authorization: ${TAP_AUTH}"

echo "Success update:"
curl -XPATCH "https://tap-gw.testpoint.io/api/messages/d3107860-98c6-446a-ac6b-1d94225ae9d5/" \
     -d '{"is_read": true}' \
     --header "Authorization: ${TAP_AUTH}"
