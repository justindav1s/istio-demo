#!/usr/bin/env bash

. ../../env.sh

OCP=https://${IP}:8443
PROJECT=istio-system
OP_PROJECT=istio-operator
USER=justin

oc login ${OCP} -u $USER

#./cleanup.sh

oc project $OP_PROJECT

oc create -n istio-system -f istio-installation-3.11_0.10.yaml

