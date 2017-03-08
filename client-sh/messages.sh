#!/bin/bash

echo "Full list of messages"
curl "https://tap-gw.testpoint.io/api/messages/" \
     --header "Authorization: ${TAP_AUTH}"

echo "Full list of messages filtered by key1=valueXXX"
curl "https://tap-gw.testpoint.io/api/messages/?key1=valueXXX" \
     --header "Authorization: ${TAP_AUTH}"

echo ""

echo "Full list of messages filtered by key1=value1"
curl "https://tap-gw.testpoint.io/api/messages/?key1=value1" \
     --header "Authorization: ${TAP_AUTH}"

echo ""
