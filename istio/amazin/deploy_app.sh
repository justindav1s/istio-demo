#!/usr/bin/env bash

. ../../env.sh

PROJECT=amazin

oc login https://${IP}:8443 -u $USER

oc delete project $PROJECT
oc new-project $PROJECT 2> /dev/null
while [ $? \> 0 ]; do
    sleep 1
    printf "."
oc new-project $PROJECT 2> /dev/null
done

oc label namespace $PROJECT istio-injection=enabled

oc adm policy add-scc-to-user anyuid -z default -n $PROJECT
oc adm policy add-scc-to-user privileged -z default -n $PROJECT
oc policy add-role-to-user view system:serviceaccount:istio-system:kiali-service-account -n $PROJECT
oc policy add-role-to-group system:image-puller system:serviceaccounts:${PROJECT} -n ${PROJECT}-images

SPRING_PROFILES_ACTIVE=prd
APP=api-gateway
oc delete configmap ${APP}-${SPRING_PROFILES_ACTIVE}-config --ignore-not-found=true -n ${PROJECT}
oc create configmap ${APP}-${SPRING_PROFILES_ACTIVE}-config --from-file=../../src/api-gateway/src/main/resources/config.${SPRING_PROFILES_ACTIVE}.properties -n ${PROJECT}
oc apply -n $PROJECT -f api-gateway.yaml
