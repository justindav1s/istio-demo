#!/usr/bin/env bash

. ../../../env.sh

PROJECT=bookinfo

oc login https://${IP}:8443 -u $USER

oc project $PROJECT

oc apply -n $PROJECT -f bookinfo-gateway.yaml
oc apply -n $PROJECT -f destination-rule-all.yaml
oc apply -n $PROJECT -f virtual-service-all-v1.yaml
