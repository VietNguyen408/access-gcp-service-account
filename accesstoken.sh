#!/bin/bash

set -euo pipefail

key_json_file="syndeno-sandbox-dee00834aba3.json"
scope="https://www.googleapis.com/auth/cloud-platform"

jwt_token=$(./jwttoken.sh "$key_json_file" "$scope")

GCP_ACCESS_TOKEN=$(curl -s -X POST https://www.googleapis.com/oauth2/v4/token \
    --data-urlencode 'grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer' \
    --data-urlencode "assertion=$jwt_token" |
    jq -r .access_token)

touch GCP_ACCESS_TOKEN.txt
destdir=GCP_ACCESS_TOKEN.txt

if [ -f "$destdir" ]; then
    echo "$GCP_ACCESS_TOKEN" >"$destdir"
fi
