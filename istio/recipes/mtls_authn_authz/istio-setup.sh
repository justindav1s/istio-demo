#!/usr/bin/env bash

oc project amazin-prod

oc delete rbacconfig --all -n istio-system
oc delete servicerole --all
oc delete servicerolebinding --all
oc delete policy --all
oc delete virtualservice --all
oc delete destinationrule --all
oc delete gateway --all

oc adm policy add-scc-to-user anyuid -z default -n amazin-prod
oc adm policy add-scc-to-user privileged -z default -n amazin-prod

oc apply -f rbac-on.yaml -n istio-system

#Authn config
oc apply -f authn-policy.yaml -n amazin-prod

#Authz config
oc apply -f authz-api-gateway.yaml -n amazin-prod
oc apply -f authz-user.yaml -n amazin-prod
oc apply -f authz-basket.yaml -n amazin-prod
oc apply -f authz-inventory.yaml -n amazin-prod

oc apply -f amazin-prd-gateway.yaml -n amazin-prod
oc apply -f amazin-prd-destrules-mtls.yaml -n amazin-prod
oc apply -f amazin-prd-vs-all-v1.yaml -n amazin-prod

istioctl authn tls-check | grep amazin-prod

