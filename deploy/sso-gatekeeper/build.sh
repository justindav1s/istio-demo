#!/usr/bin/env bash

. ../../env.sh

oc login https://${IP}:8443 -u $USER

dev_project=amazin-images
app_name=sso-gatekeeper
git_url=https://github.com/justindav1s/istio-demo.git

oc project ${dev_project}

oc delete bc sso-gatekeeper-docker-build

oc process -f docker-build-template.yml \
    -p APPLICATION_NAME=${app_name} \
    -p SOURCE_REPOSITORY_URL=${git_url} \
    -p SOURCE_REPOSITORY_REF=master \
    -p DOCKERFILE_PATH=deploy/${app_name} \
    | oc apply -n ${dev_project} -f -


oc start-build ${app_name}-docker-build --follow -n ${dev_project} || true
