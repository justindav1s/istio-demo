#!/usr/bin/env bash

. ../../../env.sh

oc project ${PROJECT}

oc delete virtualservice --all -n ${PROJECT}
oc delete destinationrule --all -n ${PROJECT}
oc delete gateway --all -n ${PROJECT}
