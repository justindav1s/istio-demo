#!/usr/bin/env bash

. ../../../env.sh

oc project ${PROJECT}

oc adm policy add-scc-to-user anyuid -z default -n ${PROJECT}
oc adm policy add-scc-to-user privileged -z default -n ${PROJECT}

oc apply -f amazin-prd-gateway.yaml -n ${PROJECT}
oc apply -f amazin-prd-destrules.yaml -n ${PROJECT}
oc apply -f amazin-prd-vs-all-v1.yaml -n ${PROJECT}

