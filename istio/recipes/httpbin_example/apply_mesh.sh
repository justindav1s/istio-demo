#!/bin/bash

oc project foo
oc apply -f httpbin-gateway.yml
oc apply -f httpbin-virtservice.yml
oc apply -f keycloak-jwt-policy.yml
