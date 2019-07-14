#!/usr/bin/env bash

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

silent=n

TOKEN=$(./get_token_direct_grant.sh)
echo $TOKEN

PART2_BASE64=$(echo ${TOKEN} | cut -d"." -f2)
PART2_BASE64=$(padBase64 ${PART2_BASE64})
echo ${PART2_BASE64} | base64 -D | jq .


HOST=https://istio-ingressgateway-istio-system.apps.192.168.33.10.xip.io/api
CURL="curl -sk -w  "%{time_total}\\n""

for i in $(seq 1 1000)
do
    [ "y" != "$silent" ] && printf "\n\n"
    [ "y" != "$silent" ] && echo Iteration \# ${i}
#    ${CURL} -H "Authorization: Bearer ${TOKEN}" -X POST -H "Content-Type: application/json" -d "{\"username\":\"justin${i}\",\"password\":\"password\"}" ${HOST}/login
    ${CURL} -v -H "Authorization: Bearer ${TOKEN}" -X DELETE ${HOST}/logout/${i}
    # ${CURL} -H "Authorization: Bearer ${TOKEN}" -X GET ${HOST}/basket/get/${i}
    # #${CURL} -H "Authorization: Bearer ${TOKEN}" -X DELETE ${HOST}/basket/remove/${i}

done
