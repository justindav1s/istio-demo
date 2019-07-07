#!/usr/bin/env bash

HOST=https://istio-ingressgateway-istio-system.apps.192.168.0.2.xip.io/api
CURL="curl -sk"


for i in $(seq 1 1000)
do
    echo Iteration \# ${i}
    echo POST -H "Content-Type: application/json" -d '{"username":"justin1","password":"password"}' ${HOST}/login
    ${CURL} -X POST -H "Content-Type: application/json" -d '{"username":"justin1","password":"password"}' ${HOST}/login
    echo
    echo POST -H "Content-Type: application/json" -d "{\"username\":\"justin${i}\",\"password\":\"password\"}" ${HOST}/login
    BASKET=$(${CURL} -X POST -H "Content-Type: application/json" -d "{\"username\":\"justin${i}\",\"password\":\"password\"}" ${HOST}/login | jq .basketId)
    echo
    echo GET ${HOST}/products/all
    ${CURL} -X GET ${HOST}/products/all
    echo
    echo GET ${HOST}/products/7
    ${CURL} -X GET ${HOST}/products/7
    echo
    echo  GET ${HOST}/products/8
    ${CURL} -X GET ${HOST}/products/800
    echo
    echo GET ${HOST}/prod/6
    ${CURL} -X GET ${HOST}/prod/6
    echo
    echo GET ${HOST}/products/5
    ${CURL} -X GET ${HOST}/products/5
    echo
    echo POST -H "Content-Type: application/json" -d '{"username":"justin1","password":"password"}' ${HOST}/user/login
    ${CURL} -X POST -H "Content-Type: application/json" -d '{"username":"justin1","password":"password"}' ${HOST}/user/login
    echo
    echo PUT ${HOST}/basket/${BASKET}/add/1
    ${CURL} -X PUT ${HOST}/basket/${BASKET}/add/1
    echo
    echo PUT ${HOST}/basket/${BASKET}/add/7
    ${CURL} -X PUT ${HOST}/basket/${BASKET}/add/7
    echo
    echo PUT ${HOST}/basket/${BASKET}/add/1
    ${CURL} -X PUT ${HOST}/basket/${BASKET}/add/1
    echo
    echo PUT ${HOST}/basket/${BASKET}/add/9
    ${CURL} -X PUT ${HOST}/basket/${BASKET}/add/9
    echo
    echo PUT ${HOST}/basket/${BASKET}/add/2
    ${CURL} -X PUT ${HOST}/basket/${BASKET}/add/2
    echo
    echo PUT ${HOST}/basket/${BASKET}/add/3
    ${CURL} -X PUT ${HOST}/basket/${BASKET}/add/3
    echo
    echo DELETE ${HOST}/basket/${BASKET}/remove/1
    ${CURL} -X DELETE ${HOST}/basket/${BASKET}/remove/1
    echo
    echo DELETE ${HOST}/basket/${BASKET}/remove/1
    ${CURL} -X DELETE ${HOST}/basket/${BASKET}/remove/1
    echo
    echo DELETE ${HOST}/basket/${BASKET}/remove/1
    ${CURL} -X DELETE ${HOST}/basket/${BASKET}/remove/1
    echo
    echo GET ${HOST}/basket/${BASKET}/empty
    ${CURL} -X DELETE ${HOST}/basket/${BASKET}/empty
    echo
    echo PUT ${HOST}/basket/${BASKET}/add/9
    ${CURL} -X PUT ${HOST}/basket/${BASKET}/add/9
    echo
    echo POST -H "Content-Type: application/json" -d '{"username":"justin1","password":"password"}' ${HOST}/login
    ${CURL} -X POST -H "Content-Type: application/json" -d '{"username":"justin1","password":"password"}' ${HOST}/login
    echo
    echo GET ${HOST}/products/all
    ${CURL} -X GET ${HOST}/products/all
done







