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
CURLTIMER="curl -sk -w "%{time_total}\\n""
CURL="curl -sk"

for i in $(seq 1 1000)
do
    [ "y" != "$silent" ] && printf "\n\n"
    [ "y" != "$silent" ] && echo Iteration \# ${i}
    echo LOGIN
    ${CURLTIMER} -H "Authorization: Bearer ${TOKEN}" -X POST -H "Content-Type: application/json" -d "{\"username\":\"justin${i}\",\"password\":\"password\"}" ${HOST}/login
    echo GET BASKETID
    BASKETID=$(${CURL} -H "Authorization: Bearer ${TOKEN}" -X POST -H "Content-Type: application/json" -d "{\"username\":\"justin${i}\",\"password\":\"password\"}" ${HOST}/login | jq .basketId)
    echo BASKET ID : ${BASKETID}
    echo LOGOUT
    ${CURL} -H "Authorization: Bearer ${TOKEN}" -X DELETE ${HOST}/logout/${i}
    echo GET BASKET : ${BASKETID}
    ${CURL} -H "Authorization: Bearer ${TOKEN}" -X GET ${HOST}/basket/get/${BASKETID}
    echo DELETE BASKET : ${BASKETID}
    ${CURL} -H "Authorization: Bearer ${TOKEN}" -X DELETE -H "Content-Type: application/json" -d "{\"id\":\"${BASKETID}\", \"userId\":\"justin${i}\"}" ${HOST}/basket/remove/${BASKETID}
    echo GET BASKET : ${BASKETID}
    ${CURL} -H "Authorization: Bearer ${TOKEN}" -X GET ${HOST}/basket/get/${BASKETID}

    printf "\n\n"
    echo LOGIN
    ${CURLTIMER} -H "Authorization: Bearer ${TOKEN}" -X POST -H "Content-Type: application/json" -d "{\"username\":\"justin${i}\",\"password\":\"password\"}" ${HOST}/login
done
