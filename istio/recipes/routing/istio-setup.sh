#!/usr/bin/env bash

. ../../../env.sh

oc project ${PROJECT}

oc apply -f amazin-prd-gateway.yaml -n ${PROJECT}
oc apply -f amazin-prd-destrules.yaml -n ${PROJECT}
oc apply -f amazin-prd-vs-all-v1.yaml -n ${PROJECT}

