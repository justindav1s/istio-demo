#!/usr/bin/env bash

. ../env.sh

oc login https://${IP}:8443 -u $USER

oc delete project $PROJECT
oc new-project $PROJECT  2> /dev/null
while [ $? \> 0 ]; do
    sleep 1
    printf "."
    oc new-project $PROJECT 2> /dev/null
done


oc policy add-role-to-user edit system:serviceaccount:${CICD_PROJECT}:jenkins -n ${PROJECT}
oc policy add-role-to-user edit system:serviceaccount:${CICD_PROJECT}:default -n ${PROJECT}
oc policy add-role-to-user view --serviceaccount=default -n ${PROJECT}

oc project ${PROJECT}

cd user && setup.sh && cd -
cd basket && setup.sh && cd -
cd api-gateway && setup.sh && cd -
cd inventory && ./setup_v1.sh &&  ./setup_v2.sh && ./setup_v3.sh && cd -
cd web && setup.sh && cd -
cd websso && setup.sh && cd -
