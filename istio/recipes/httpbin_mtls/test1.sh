#!/bin/bash


for from in "foo" "bar" "legacy";
do
	for to in "foo" "bar" "legacy";
	do 
		oc exec $(oc get pod -l app=sleep -n ${from} -o jsonpath={.items..metadata.name}) -c sleep -n ${from} -- curl "http://httpbin.${to}:8000/ip" -s -o /dev/null -w "sleep.${from} to httpbin.${to}: %{http_code}\n";
	done;
done

