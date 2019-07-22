#!/usr/bin/env bash

#set -x

APP=sso-gatekeeper-inventory

. ../../../env.sh

oc login https://${IP}:8443 -u $USER

oc project ${PROJECT}

#oc delete all -l app=${APP} -n ${PROJECT}
#oc delete pvc -l app=${APP} -n ${PROJECT}
oc delete is,bc,dc,svc,route,sa ${APP} -n ${PROJECT}
oc delete sa ${APP}-sa -n ${PROJECT}
oc delete configmap ${APP}-config -n ${PROJECT}
oc delete configmap ${APP}-gatekeeper-config -n ${PROJECT}

echo Setting up ${APP} for ${PROJECT}
oc new-app -f ../ocp/gatekeeper-sidecar-template.yaml \
    -p APPLICATION_NAME=${APP}

oc create configmap ${APP}-gatekeeper-config --from-file=../config/gatekeeper.yaml -n ${PROJECT}
oc create configmap ${APP}-config --from-file=../config/config.dev.properties -n ${PROJECT}