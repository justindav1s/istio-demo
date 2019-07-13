#!/usr/bin/env bash

while :
do
	curl -q http://istio-ingressgateway-istio-system.apps.192.168.33.10.xip.io/productpage
	sleep 1
done
