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
[ "y" != "$silent" ] && echo $TOKEN

PART2_BASE64=$(echo ${TOKEN} | cut -d"." -f2)
PART2_BASE64=$(padBase64 ${PART2_BASE64})
[ "y" != "$silent" ] && echo ${PART2_BASE64} | base64 -D | jq .


HOST=https://istio-ingressgateway-istio-system.apps.192.168.33.10.xip.io/api
CURLTIMER="curl -sk -w "%{time_total}\\n""
CURLTIMER="curl -sk -w "%{time_total}\\n" -o /dev/null"
CURL="curl -sk"
CURL="curl -sk -o /dev/null"

for i in $(seq 1 1000)
do
    [ "y" != "$silent" ] && printf "\n\n"
    [ "y" != "$silent" ] && echo Iteration \# ${i}
    [ "y" != "$silent" ] && echo CLEAR ALL BASKETS
    ${CURL} -H "Authorization: Bearer ${TOKEN}" -X DELETE ${HOST}/basket/clearall
    [ "y" != "$silent" ] && echo LOGIN
    ${CURLTIMER} -H "Authorization: Bearer ${TOKEN}" -X POST -H "Content-Type: application/json" -d "{\"username\":\"justin${i}\",\"password\":\"password\"}" ${HOST}/login
    [ "y" != "$silent" ] && echo GET BASKETID
    BASKETID=$(${CURL} -H "Authorization: Bearer ${TOKEN}" -X POST -H "Content-Type: application/json" -d "{\"username\":\"justin${i}\",\"password\":\"password\"}" ${HOST}/login | jq .basketId)
    [ "y" != "$silent" ] && echo BASKET ID : ${BASKETID}
    [ "y" != "$silent" ] && echo LOGOUT
    ${CURL} -H "Authorization: Bearer ${TOKEN}" -X DELETE ${HOST}/logout/${i}
    [ "y" != "$silent" ] && echo GET BASKET : ${BASKETID}
    ${CURL} -H "Authorization: Bearer ${TOKEN}" -X GET ${HOST}/basket/get/${BASKETID}
    [ "y" != "$silent" ] && echo DELETE BASKET : ${BASKETID}
    ${CURL} -H "Authorization: Bearer ${TOKEN}" -X DELETE -H "Content-Type: application/json" -d "{\"id\":\"${BASKETID}\", \"userId\":\"justin${i}\"}" ${HOST}/basket/remove/${BASKETID}
    [ "y" != "$silent" ] && echo GET BASKET : ${BASKETID}
    ${CURL} -H "Authorization: Bearer ${TOKEN}" -X GET ${HOST}/basket/get/${BASKETID}

    [ "y" != "$silent" ] && printf "\n\n"
    [ "y" != "$silent" ] && echo LOGIN
    ${CURLTIMER} -H "Authorization: Bearer ${TOKEN}" -X POST -H "Content-Type: application/json" -d "{\"username\":\"justin${i}\",\"password\":\"password\"}" ${HOST}/login
done
