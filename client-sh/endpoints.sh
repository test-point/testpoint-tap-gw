#!/bin/bash
# if you update metadata on your real values you'll see how it works
curl "https://tap-gw.testpoint.io/api/endpoints/" \
     --header "Authorization: ${TAP_AUTH}"

echo ""

curl "https://tap-gw.testpoint.io/api/endpoints/?keyX=asdf" \
     --header "Authorization: ${TAP_AUTH}"

echo ""

curl "https://tap-gw.testpoint.io/api/endpoints/?keyX=value1" \
     --header "Authorization: ${TAP_AUTH}"

echo ""
