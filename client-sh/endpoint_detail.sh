#!/bin/bash

echo "Visible:"
curl "https://tap-gw.testpoint.io/api/endpoints/3ad4ade1-a704-4840-a601-cf7f5c1812bc/" \
     --header "Authorization: ${TAP_AUTH}"
