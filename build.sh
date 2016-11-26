#!/bin/bash

set -x

apk update

apk add wget git ctags zip

mkdir -p /tmp/opengrok
cd /tmp/opengrok
wget -O opengrok.tar.gz https://github.com/OpenGrok/OpenGrok/files/467358/opengrok-0.12.1.6.tar.gz
tar -zxvf opengrok.tar.gz -C /var
rm opengrok.tar.gz

rm -rf /var/cache/apk/*
