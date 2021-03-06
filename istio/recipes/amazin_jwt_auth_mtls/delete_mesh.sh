#!/bin/bash

oc project amazin

oc delete policy,destinationrules,gateway,virtualservice --all

oc delete -f amazin-gateway.yml
oc delete -f amazin-virtservice.yml
oc delete -f ns-policy-mtls-on.yml
oc delete -f destinationrule-ns-mtls-on.yml
oc delete -f keycloak-jwt-policy.yml
