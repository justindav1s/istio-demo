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

KEYCLOAK=https://sso-sso.apps.192.168.33.10.xip.io
CLIENT_SECRET="323cadf9-6cc6-4693-8145-ca371d816f53"

KEYCLOAK=https://sso-sso.apps.ocp.datr.eu
CLIENT_SECRET="4067e61d-377b-4995-bdc9-d08381567cf5"

REALM="amazin"
GRANT_TYPE="password"
USER="justin"
USER_PASSWORD="12jnd34"
CLIENT="webapp"




#echo "Keycloak host : $KEYCLOAK"


#Get Token
POST_BODY="grant_type=${GRANT_TYPE}&client_id=${CLIENT}&client_secret=${CLIENT_SECRET}&username=${USER}&password=${USER_PASSWORD}"

#POST_BODY="grant_type=${GRANT_TYPE}&client_id=${CLIENT}&username=${USER}&password=${USER_PASSWORD}"


#echo "Keycloak host : $KEYCLOAK"
#echo POST_BODY=${POST_BODY}

RESPONSE=$(curl -qsk \
    -d ${POST_BODY} \
    -H "Content-Type: application/x-www-form-urlencoded" \
    ${KEYCLOAK}/auth/realms/${REALM}/protocol/openid-connect/token)

#echo "RESPONSE"=${RESPONSE}
ACCESS_TOKEN=$(echo ${RESPONSE} | jq -r .access_token)
PART2_BASE64=$(echo ${ACCESS_TOKEN} | cut -d"." -f2)
PART2_BASE64=$(padBase64 ${PART2_BASE64})
#echo ${PART2_BASE64} | base64 -D | jq .

echo $ACCESS_TOKEN
