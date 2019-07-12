#!/usr/bin/env bash

export IP=192.168.33.10.xip.io
export USER=justin

export CICD_PROJECT=cicd
export PROJECT=amazin

export CURL="curl -k -v"
export JENKINS=jenkins-cicd.apps.192.168.33.10.xip.io
export JENKINS_TOKEN=11df692371a067ba933cfd4ed8465d8a8c
export JENKINS_USER=justin-admin-edit-view

export DOMAIN=$CICD_PROJECT
export DATABASE_USER="sonar"
export DATABASE_PASSWORD="sonar"
export DATABASE_URL="jdbc:postgresql://postgresql/sonar"

export REGISTRY="docker-registry.default.svc:5000"
