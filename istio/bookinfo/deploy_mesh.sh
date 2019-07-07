#!/usr/bin/env bash

. ../../env.sh

PROJECT=bookinfo

oc login https://${IP}:8443 -u $USER

oc project $PROJECT


oc apply -n $PROJECT -f https://raw.githubusercontent.com/Maistra/bookinfo/master/bookinfo-gateway.yaml

sleep 5

oc apply -n $PROJECT -f https://raw.githubusercontent.com/istio/istio/release-1.1/samples/bookinfo/networking/destination-rule-all.yaml

sleep 5

oc apply -f https://raw.githubusercontent.com/istio/istio/release-1.2/samples/bookinfo/networking/virtual-service-all-v1.yaml

export GATEWAY_URL=$(oc get route -n istio-system istio-ingressgateway -o jsonpath='{.spec.host}')

echo GATEWAY_URL : $GATEWAY_URL
