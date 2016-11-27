#!/bin/bash

set -x

apk update

apk add wget git ctags zip

mkdir -p /tmp/opengrok
cd /tmp/opengrok
wget -O opengrok.tar.gz.zip https://github.com/OpenGrok/OpenGrok/files/467358/opengrok-0.12.1.6.tar.gz.zip
unzip opengrok.tar.gz.zip
tar -zxvf opengrok-*.tar.gz -C /var

mv /var/opengrok* /var/opengrok
/var/opengrok/bin/OpenGrok deploy

mkdir -p /var/opengrok/src

mkdir -p /opt/tomcat/webapps/ROOT/
mv /index.html /opt/tomcat/webapps/ROOT/

rm opengrok*

rm -rf /var/cache/apk/*
