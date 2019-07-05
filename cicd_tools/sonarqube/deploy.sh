#!/usr/bin/env bash

. ../env.sh

oc login https://${IP}:8443 -u justin

APP=sonarqube

oc project $CICD_PROJECT

oc delete imagestream ${APP}
oc delete buildconfig ${APP}-docker-build
oc delete deploymentconfig ${APP}
oc delete persistentvolumeclaim ${APP}-data
oc delete persistentvolumeclaim ${APP}-extensions
oc delete serviceaccounts ${APP}
oc delete service ${APP}
oc delete route ${APP}


oc new-app -f sonarqube-persistent-template.yml \
    -p DOMAIN=${DOMAIN} \
    -p APPLICATION_NAME=${APP} \
    -p SOURCE_REPOSITORY_URL=https://github.com/justindav1s/microservices-on-openshift.git \
    -p SOURCE_REPOSITORY_URL=master \
    -p DOCKERFILE_PATH="cicd_tools/sonarqube" \
    -p SONARQUBE_JDBC_USERNAME=${DATABASE_USER} \
    -p SONARQUBE_JDBC_PASSWORD=${DATABASE_PASSWORD} \
    -p SONARQUBE_JDBC_URL=${DATABASE_URL}



#then download quality profile from market place https://sonarqube-cicd.apps.ocp.datr.eu/admin/marketplace
