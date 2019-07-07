#!/usr/bin/env bash

oc delete ServiceMeshControlPlane "basic-install" -n istio-system
