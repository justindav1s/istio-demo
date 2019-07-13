#!/bin/bash

oc project amazin

for from in "api-gateway" "user" "basket"
do
	for to in "api-gateway-prd" "user-prd" "basket-prd" "inventory-prd";
	do
		version=v1
		oc exec $(oc get pod -l app=${from},version=${version} -o jsonpath={.items..metadata.name}) -c ${from} -- curl "http://${to}:8080" -s -o /dev/null -w "${from}-${version} to ${to}: %{http_code}\n";
	done;
done

from=inventory
for version in "v1" "v2" "v3"
do
	for to in "api-gateway-prd" "user-prd" "basket-prd" "inventory-prd";
	do
		oc exec $(oc get pod -l app=${from},version=${version} -o jsonpath={.items..metadata.name}) -c ${from} -- curl "http://${to}:8080" -s -o /dev/null -w "${from}-${version} to ${to}: %{http_code}\n";
	done;
done;
