#!/usr/bin/env bash

oc delete servicemeshcontrolplane.maistra.io "basic-install" -n istio-system

oc delete project istio-operator

oc delete customresourcedefinitions.apiextensions.k8s.io cloudwatches.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io dogstatsds.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io virtualservices.networking.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io destinationrules.networking.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io serviceentries.networking.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io gateways.networking.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io envoyfilters.networking.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io policies.authentication.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io meshpolicies.authentication.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io httpapispecbindings.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io httpapispecs.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io quotaspecbindings.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io quotaspecs.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io rules.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io attributemanifests.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io bypasses.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io circonuses.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io deniers.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io fluentds.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io kubernetesenvs.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io listcheckers.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io memquotas.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io noops.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io opas.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io prometheuses.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io rbacs.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io redisquotas.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io servicecontrols.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io signalfxs.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io solarwindses.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io stackdrivers.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io statsds.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io stdios.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io apikeys.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io authorizations.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io checknothings.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io kuberneteses.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io listentries.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io logentries.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io edges.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io metrics.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io quotas.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io reportnothings.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io servicecontrolreports.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io tracespans.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io rbacconfigs.rbac.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io serviceroles.rbac.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io servicerolebindings.rbac.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io adapters.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io instances.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io templates.config.istio.io
oc delete customresourcedefinitions.apiextensions.k8s.io handlers.config.istio.io

oc delete clusterroles.rbac.authorization.k8s.io istio-authenticated
oc delete clusterrolebindings.rbac.authorization.k8s.io istio-authenticated

oc delete validatingwebhookconfigurations.admissionregistration.k8s.io istio-galley
oc delete mutatingwebhookconfigurations istio-sidecar-injector

oc delete customresourcedefinition certificates.certmanager.k8s.io challenges.certmanager.k8s.io clusterissuers.certmanager.k8s.io clusterrbacconfigs.rbac.istio.io
oc delete customresourcedefinition controlplanes.istio.openshift.com installations.istio.openshift.com issuers.certmanager.k8s.io orders.certmanager.k8s.io sidecars.networking.istio.io zipkins.config.istio.io

oc delete crd monitoringdashboards.monitoring.kiali.io


oc delete crd installations.istio.openshift.com


oc delete project istio-system
