#!/usr/bin/env bash

APP=inventory
ENV=prd
IMAGE_NAME=${APP}
IMAGE_TAG=0.0.1-SNAPSHOT
SPRING_PROFILES_ACTIVE=v3
VERSION_LABEL=v3
SERVICEACCOUNT_NAME=${APP}-${ENV}-sa
SERVICE_NAME=${APP}-${ENV}

. ../../env.sh

oc login https://${IP}:8443 -u $USER

oc project ${PROD_PROJECT}

oc delete dc ${APP}-${VERSION_LABEL} -n ${PROD_PROJECT}
oc delete deployments ${APP}-${VERSION_LABEL} -n ${PROD_PROJECT}

oc delete configmap ${APP}-${SPRING_PROFILES_ACTIVE}-config --ignore-not-found=true -n ${PROD_PROJECT}
oc create configmap ${APP}-${SPRING_PROFILES_ACTIVE}-config --from-file=../../src/inventory/src/main/resources/config.${SPRING_PROFILES_ACTIVE}.properties -n ${PROD_PROJECT}

oc new-app -f ../spring-boot-prd-deploy-dc-template.yaml \
    -p APPLICATION_NAME=${APP} \
    -p IMAGE_NAME=${IMAGE_NAME} \
    -p IMAGE_TAG=${IMAGE_TAG} \
    -p SPRING_PROFILES_ACTIVE=${SPRING_PROFILES_ACTIVE} \
    -p VERSION_LABEL=${VERSION_LABEL} \
    -p SERVICEACCOUNT_NAME=${SERVICEACCOUNT_NAME}

oc set triggers dc/${APP}-${VERSION_LABEL} --remove-all