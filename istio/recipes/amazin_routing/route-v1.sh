#!/usr/bin/env bash

. ../../../env.sh

oc project ${PROJECT}

oc replace -f v1-routing-rule.yaml



