#!/bin/bash

oc project foo
oc delete -f httpbin-gateway.yml
oc delete -f httpbin-virtservice.yml
oc delete -f keycloak-jwt-policy.yml
