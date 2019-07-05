#!/usr/bin/env bash

export IP=192.168.0.22.xip.io
export USER=justin

export CICD_PROJECT=cicd
export PROJECT=amazin

#Set Postgresql up like this :
#Database Service Name
#postgresql-sonar
#The name of the OpenShift Service exposed for the database.
#
#PostgreSQL Connection Username
#sonar
#Username for PostgreSQL user that will be used for accessing the database.
#
#PostgreSQL Connection Password
#sonar
#Password for the PostgreSQL connection user.
#
#PostgreSQL Database Name
#sonar

export DOMAIN=$CICD_PROJECT
export DATABASE_USER="sonar"
export DATABASE_PASSWORD="sonar"
export DATABASE_URL="jdbc:postgresql://postgresql/sonar"
