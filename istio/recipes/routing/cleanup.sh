#!/usr/bin/env bash

oc delete servicerole --all -n amazin
oc delete virtualservice --all -n amazin
oc delete destinationrule --all -n amazin
oc delete gateway --all -n amazin
