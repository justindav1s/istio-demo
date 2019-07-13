#!/usr/bin/env bash

APP=inventory
ENV=prd
IMAGE_NAME=${APP}
IMAGE_TAG=0.0.1-SNAPSHOT
SPRING_PROFILES_ACTIVE=v2
VERSION_LABEL=v2
SERVICEACCOUNT_NAME=${APP}-${ENV}-sa
SERVICE_NAME=${APP}-${ENV}

. ../../env.sh

oc login https://${IP}:8443 -u $USER

oc project ${PROJECT}

oc delete dc ${APP}-${VERSION_LABEL} -n ${PROJECT}
oc delete deployments ${APP}-${VERSION_LABEL} -n ${PROJECT}
oc delete svc ${SERVICE_NAME} -n ${PROJECT}

oc delete configmap ${APP}-${SPRING_PROFILES_ACTIVE}-config --ignore-not-found=true -n ${PROJECT}
oc create configmap ${APP}-${SPRING_PROFILES_ACTIVE}-config --from-file=../../src/${APP}/src/main/resources/config.${SPRING_PROFILES_ACTIVE}.properties -n ${PROJECT}

oc new-app -f ../service-template.yaml \
    -p APPLICATION_NAME=${APP} \
    -p SERVICEACCOUNT_NAME=${SERVICEACCOUNT_NAME} \
    -p SERVICE_NAME=${SERVICE_NAME}

sleep 2

oc adm policy add-scc-to-user anyuid -z ${SERVICEACCOUNT_NAME}
oc adm policy add-scc-to-user privileged -z ${SERVICEACCOUNT_NAME}

sleep 2

oc new-app -f ../spring-boot-deploy-template.yaml \
    -p APPLICATION_NAME=${APP} \
    -p IMAGE_NAME=${IMAGE_NAME} \
    -p IMAGE_TAG=${IMAGE_TAG} \
    -p SPRING_PROFILES_ACTIVE=${SPRING_PROFILES_ACTIVE} \
    -p VERSION_LABEL=${VERSION_LABEL} \
    -p SERVICEACCOUNT_NAME=${SERVICEACCOUNT_NAME}

oc set image deploy/${APP}-${VERSION_LABEL} ${APP}=${REGISTRY}/${PROJECT}-images/${APP}:latest
