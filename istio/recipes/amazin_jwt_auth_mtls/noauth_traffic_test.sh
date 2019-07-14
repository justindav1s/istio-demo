#!/usr/bin/env bash

HOST=https://istio-ingressgateway-istio-system.apps.192.168.33.10.xip.io/api
CURL="curl -sk"

for i in $(seq 1 1)
do
    printf "\n\n"
    echo Iteration \# ${i}
    echo Iteration \# ${i}
    echo POST -H "Content-Type: application/json" -d "{\"username\":\"justin${i}\",\"password\":\"password\"}" ${HOST}/login
    ${CURL} -X POST -H "Content-Type: application/json" -d "{\"username\":\"justin${i}\",\"password\":\"password\"}" ${HOST}/login
    printf "\n\n"
    BASKET=$(${CURL} -X POST -H "Content-Type: application/json" -d "{\"username\":\"justin${i}\",\"password\":\"password\"}" ${HOST}/login | jq .basketId)
    echo BASKET ID : ${BASKET}
    printf "\n\n"
    echo GET ${HOST}/products/all
    ${CURL} -X GET ${HOST}/products/all
    printf "\n\n"
    echo GET ${HOST}/products/7
    ${CURL} -X GET ${HOST}/products/7
    printf "\n\n"
    echo PUT ${HOST}/basket/${BASKET}/add/1
    ${CURL} -X PUT ${HOST}/basket/${BASKET}/add/1
    printf "\n\n"
    echo PUT ${HOST}/basket/${BASKET}/add/7
    ${CURL} -X PUT ${HOST}/basket/${BASKET}/add/7
    printf "\n\n"
    echo DELETE ${HOST}/basket/${BASKET}/remove/1
    ${CURL} -X DELETE ${HOST}/basket/${BASKET}/remove/1
    printf "\n\n"
    echo GET ${HOST}/basket/${BASKET}/empty
    ${CURL} -X DELETE ${HOST}/basket/${BASKET}/empty
    printf "\n\n"
    echo PUT ${HOST}/basket/${BASKET}/add/9
    ${CURL} -X PUT ${HOST}/basket/${BASKET}/add/9
done
