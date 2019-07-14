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

silent=y


TOKEN=$(./get_token_direct_grant.sh)
echo $TOKEN

PART2_BASE64=$(echo ${TOKEN} | cut -d"." -f2)
PART2_BASE64=$(padBase64 ${PART2_BASE64})
echo ${PART2_BASE64} | base64 -D | jq .


HOST=https://istio-ingressgateway-istio-system.apps.192.168.33.10.xip.io/api
CURL="curl -sk"

for i in $(seq 1 1000)
do
    printf "\n\n"
    echo Iteration \# ${i}
    echo POST -H "Content-Type: application/json" -d "{\"username\":\"justin${i}\",\"password\":\"password\"}" ${HOST}/login
    ${CURL} -H "Authorization: Bearer ${TOKEN}" -X POST -H "Content-Type: application/json" -d "{\"username\":\"justin${i}\",\"password\":\"password\"}" ${HOST}/login
    printf "\n\n"
    BASKET=$(${CURL} -H "Authorization: Bearer ${TOKEN}" -X POST -H "Content-Type: application/json" -d "{\"username\":\"justin${i}\",\"password\":\"password\"}" ${HOST}/login | jq .basketId)
    echo BASKET ID : ${BASKET}
    printf "\n\n"
    echo GET ${HOST}/products/all
    ${CURL} -H "Authorization: Bearer ${TOKEN}" -X GET ${HOST}/products/all
    printf "\n\n"
    echo GET ${HOST}/products/7
    ${CURL} -H "Authorization: Bearer ${TOKEN}" -X GET ${HOST}/products/7
    printf "\n\n"
    echo PUT ${HOST}/basket/${BASKET}/add/1
    ${CURL} -H "Authorization: Bearer ${TOKEN}" -X PUT ${HOST}/basket/${BASKET}/add/1
    printf "\n\n"
    echo PUT ${HOST}/basket/${BASKET}/add/7
    ${CURL} -H "Authorization: Bearer ${TOKEN}" -X PUT ${HOST}/basket/${BASKET}/add/7
    printf "\n\n"
    echo DELETE ${HOST}/basket/${BASKET}/remove/1
    ${CURL} -H "Authorization: Bearer ${TOKEN}" -X DELETE ${HOST}/basket/${BASKET}/remove/1
    printf "\n\n"
    echo GET ${HOST}/basket/${BASKET}/empty
    ${CURL} -H "Authorization: Bearer ${TOKEN}" -X DELETE ${HOST}/basket/${BASKET}/empty
    printf "\n\n"
    echo PUT ${HOST}/basket/${BASKET}/add/9
    ${CURL} -H "Authorization: Bearer ${TOKEN}" -X PUT ${HOST}/basket/${BASKET}/add/9
done
