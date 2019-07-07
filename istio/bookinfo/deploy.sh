#!/usr/bin/env bash

. ../../env.sh

PROJECT=bookinfo

oc login https://${IP}:8443 -u $USER

oc delete project $PROJECT
oc new-project $PROJECT 2> /dev/null
while [ $? \> 0 ]; do
    sleep 1
    printf "."
oc new-project $PROJECT 2> /dev/null
done

oc adm policy add-scc-to-user anyuid -z default -n $PROJECT
oc adm policy add-scc-to-user privileged -z default -n $PROJECT
oc apply -n $PROJECT -f https://raw.githubusercontent.com/Maistra/bookinfo/master/bookinfo.yaml

oc apply -n $PROJECT -f https://raw.githubusercontent.com/Maistra/bookinfo/master/bookinfo-gateway.yaml

oc apply -n $PROJECT -f https://raw.githubusercontent.com/istio/istio/release-1.1/samples/bookinfo/networking/destination-rule-all.yaml

sleep 2

export GATEWAY_URL=$(oc get route -n istio-system istio-ingressgateway -o jsonpath='{.spec.host}')

echo GATEWAY_URL : $GATEWAY_URL
