#!/usr/bin/env bash

#set -x

APP=websso
S2I_IMAGE=nginx:1.10

. ../../env.sh

oc login https://${IP}:8443 -u $USER

oc project ${PROJECT}

oc delete all -l app=${APP} -n ${PROJECT}
oc delete pvc -l app=${APP} -n ${PROJECT}
oc delete bc,dc,svc,route ${APP} -n ${PROJECT}
oc delete template ${APP}-prod-dc -n ${PROJECT}
oc delete configmap ${APP}-config -n ${PROJECT}

echo Setting up ${APP} for ${PROJECT}
oc new-app -f ../web-prd-template.yaml -p APP_NAME=${APP} --allow-missing-imagestream-tags=true -n ${PROJECT}

