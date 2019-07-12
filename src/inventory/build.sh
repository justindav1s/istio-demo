#!/usr/bin/env bash

. ../../env.sh

APP=inventory
PROJECT=${PROJECT}-images

MVN="mvn -U -s ../settings.xml -Dmaven.wagon.http.ssl.insecure=true -Dmaven.wagon.http.ssl.allowall=true"

${MVN} clean install -Dspring.profiles.active=dev -DskipTests

BASE_IMAGE_NAMESPACE=openshift
BASE_IMAGE=redhat-openjdk18-openshift:1.4

oc project ${PROJECT}
oc delete bc,is ${APP}

oc new-app -f ../image-build-template.yaml \
      -p APPLICATION_NAME=${APP} \
      -p BASE_IMAGE_NAMESPACE=${BASE_IMAGE_NAMESPACE} \
      -p BASE_IMAGE=${BASE_IMAGE}

oc start-build ${APP} --from-file=target/${APP}-0.0.1-SNAPSHOT.jar --follow -n $PROJECT
