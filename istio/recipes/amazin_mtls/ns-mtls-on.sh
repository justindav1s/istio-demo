#!/bin/bash

oc project amazin

oc apply -f ns-policy-mtls-on.yml
oc apply -f destinationrule-ns-mtls-on.yml
oc apply -f amazin-prd-gateway.yaml
