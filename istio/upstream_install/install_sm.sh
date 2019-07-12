#!/usr/bin/env bash

. ../../env.sh

OCP=https://${IP}:8443

oc login ${OCP} -u $USER

PROJECT=istio-system

oc delete project ${PROJECT}
oc new-project ${PROJECT} 2> /dev/null
while [ $? \> 0 ]; do
    sleep 1
    printf "."
oc new-project ${PROJECT} 2> /dev/null
done

oc adm policy add-scc-to-user anyuid -z istio-ingress-service-account -n ${PROJECT}
oc adm policy add-scc-to-user anyuid -z default -n ${PROJECT}
oc adm policy add-scc-to-user anyuid -z prometheus -n ${PROJECT}
oc adm policy add-scc-to-user anyuid -z istio-egressgateway-service-account -n ${PROJECT}
oc adm policy add-scc-to-user anyuid -z istio-citadel-service-account -n ${PROJECT}
oc adm policy add-scc-to-user anyuid -z istio-ingressgateway-service-account -n ${PROJECT}
oc adm policy add-scc-to-user anyuid -z istio-cleanup-old-ca-service-account -n ${PROJECT}
oc adm policy add-scc-to-user anyuid -z istio-mixer-post-install-account -n ${PROJECT}
oc adm policy add-scc-to-user anyuid -z istio-mixer-service-account -n ${PROJECT}
oc adm policy add-scc-to-user anyuid -z istio-pilot-service-account -n ${PROJECT}
oc adm policy add-scc-to-user anyuid -z istio-sidecar-injector-service-account -n ${PROJECT}
oc adm policy add-scc-to-user anyuid -z istio-galley-service-account -n ${PROJECT}
oc adm policy add-scc-to-user anyuid -z istio-security-post-install-account -n ${PROJECT}

cd istio-1.2.2

for i in install/kubernetes/helm/istio-init/files/crd*yaml; do oc delete -f $i -n ${PROJECT}; done

for i in install/kubernetes/helm/istio-init/files/crd*yaml; do oc apply -f $i -n ${PROJECT}; done

oc apply -f install/kubernetes/istio-demo.yaml -n ${PROJECT}

10057  oc policy add-role-to-user view system:serviceaccount:istio-system:kiali-service-account -n amazin
10058  oc policy add-role-to-user view system:serviceaccount:istio-system:kiali-service-account -n cicd
10059  oc policy add-role-to-user view system:serviceaccount:istio-system:kiali-service-account -n default
10060  oc policy add-role-to-user view system:serviceaccount:istio-system:kiali-service-account -n istio-system
10061  oc policy add-role-to-user view system:serviceaccount:istio-system:kiali-service-account -n sso
10062  oc policy add-role-to-user view system:serviceaccount:istio-system:kiali-service-account -n management-infra
#edit kiali configmap yo point to http://grafana:3000
#make an ingress route that points at the http2 service port
#add this for each project kiali wants to see : oc policy add-role-to-user view system:serviceaccount:istio-system:kiali-service-account -n bookinfo
