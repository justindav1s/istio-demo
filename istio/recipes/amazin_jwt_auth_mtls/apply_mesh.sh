#!/bin/bash

oc project amazin

oc delete policy,destinationrules,gateway,virtualservice --all

oc apply -f amazin-gateway.yml
oc apply -f amazin-virtservice.yml
oc apply -f keycloak-jwt-policy.yml
