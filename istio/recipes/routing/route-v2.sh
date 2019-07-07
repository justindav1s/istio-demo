#!/usr/bin/env bash

. ../../../env.sh

oc project ${PROJECT}

oc replace -f v2-routing-rule.yaml



