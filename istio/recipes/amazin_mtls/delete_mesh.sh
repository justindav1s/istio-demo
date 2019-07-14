#!/bin/bash

oc project amazin

oc delete policy,destinationrules,gateway,virtualservice --all

oc delete -f ns-policy-mtls-on.yml
oc delete -f destinationrule-ns-mtls-on.yml
oc delete -f amazin-prd-gateway.yaml
