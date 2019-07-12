#!/usr/bin/env bash

APP=basket

. ../../env.sh

MVN="mvn -U -s ../settings.xml -Dmaven.wagon.http.ssl.insecure=true -Dmaven.wagon.http.ssl.allowall=true"


${MVN} clean install -Dspring.profiles.active=dev -DskipTests
