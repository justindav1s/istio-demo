#!/bin/bash

oc apply -f foo-policy-mtls-on.yml
oc apply -f destinationrule-foo-mtls-on.yml
