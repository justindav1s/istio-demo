#!/usr/bin/env bash

silent=y

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
    ${CURL} -X DELETE ${HOST}/basket/clearall
    [ "y" != "$silent" ] && echo LOGIN
    ${CURLTIMER} -X POST -H "Content-Type: application/json" -d "{\"username\":\"justin${i}\",\"password\":\"password\"}" ${HOST}/login
    [ "y" != "$silent" ] && echo GET BASKETID
    BASKETID=$(${CURL} -X POST -H "Content-Type: application/json" -d "{\"username\":\"justin${i}\",\"password\":\"password\"}" ${HOST}/login | jq .basketId)
    [ "y" != "$silent" ] && echo BASKET ID : ${BASKETID}
    [ "y" != "$silent" ] && echo LOGOUT
    ${CURL}  -X DELETE ${HOST}/logout/${i}
    [ "y" != "$silent" ] && echo GET BASKET : ${BASKETID}
    ${CURL}  -X GET ${HOST}/basket/get/${BASKETID}
    [ "y" != "$silent" ] && echo DELETE BASKET : ${BASKETID}
    ${CURL}  -X DELETE -H "Content-Type: application/json" -d "{\"id\":\"${BASKETID}\", \"userId\":\"justin${i}\"}" ${HOST}/basket/remove/${BASKETID}
    [ "y" != "$silent" ] && echo GET BASKET : ${BASKETID}
    ${CURL}  -X GET ${HOST}/basket/get/${BASKETID}

    [ "y" != "$silent" ] && printf "\n\n"
    [ "y" != "$silent" ] && echo LOGIN
    ${CURLTIMER} -H "Authorization: Bearer ${TOKEN}" -X POST -H "Content-Type: application/json" -d "{\"username\":\"justin${i}\",\"password\":\"password\"}" ${HOST}/login
done
