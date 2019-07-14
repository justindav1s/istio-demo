#!/usr/bin/env bash

oc project amazin

oc delete policy,destinationrules,gateway,virtualservice --all

oc apply -f amazin-prd-gateway.yaml
