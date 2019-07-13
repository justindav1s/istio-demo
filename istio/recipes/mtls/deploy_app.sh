#!/bin/bash

LOC="/Users/jusdavis/github/istio-demo/istio/upstream_install/istio-1.2.2"


PROJECT=foo
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
oc apply -f  ${LOC}/samples/httpbin/httpbin.yaml -n $PROJECT
oc apply -f  ${LOC}/samples/sleep/sleep.yaml -n $PROJECT
oc adm policy add-scc-to-user privileged -z sleep -n $PROJECT

PROJECT=bar
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
oc apply -f  ${LOC}/samples/httpbin/httpbin.yaml -n $PROJECT
oc apply -f  ${LOC}/samples/sleep/sleep.yaml -n $PROJECT
oc adm policy add-scc-to-user privileged -z sleep -n $PROJECT

PROJECT=legacy
oc delete project $PROJECT
oc new-project $PROJECT 2> /dev/null
while [ $? \> 0 ]; do
    sleep 1
    printf "."
oc new-project $PROJECT 2> /dev/null
done
oc adm policy add-scc-to-user anyuid -z default -n $PROJECT
oc adm policy add-scc-to-user privileged -z default -n $PROJECT
oc apply -f ${LOC}/samples/httpbin/httpbin.yaml -n $PROJECT
oc apply -f ${LOC}/samples/sleep/sleep.yaml -n $PROJECT
oc adm policy add-scc-to-user privileged -z sleep -n $PROJECT
