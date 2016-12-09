#!/bin/sh

set -x
apk update

apk add openssh

rm -rf /var/cache/apk/*
