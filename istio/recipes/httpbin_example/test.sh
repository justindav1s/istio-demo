#!/bin/bash

function padBase64  {
    STR=$1
    MOD=$((${#STR}%4))
    if [ $MOD -eq 1 ]; then
       STR="${STR}="
    elif [ $MOD -gt 1 ]; then
       STR="${STR}=="
    fi
    echo ${STR}
}

TOKEN=$(./get_token_direct_grant.sh)
echo $TOKEN

PART2_BASE64=$(echo ${TOKEN} | cut -d"." -f2)
PART2_BASE64=$(padBase64 ${PART2_BASE64})
echo ${PART2_BASE64} | base64 -D | jq .

echo WITH TOKEN
curl -k \
    -H "Authorization: Bearer ${TOKEN}" \
		https://istio-ingressgateway-istio-system.apps.192.168.33.10.xip.io/headers

echo WITHOUT_TOKEN
curl -k https://istio-ingressgateway-istio-system.apps.192.168.33.10.xip.io/headers
