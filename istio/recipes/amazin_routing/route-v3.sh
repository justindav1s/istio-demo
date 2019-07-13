#!/usr/bin/env bash

. ../../../env.sh

oc project ${PROJECT}

oc replace -f v3-routing-rule.yaml



