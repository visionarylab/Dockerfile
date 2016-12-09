#!/bin/sh

if [[ "${DOCKER_DEBUG}" == "1" ]]; then
    set -x
fi

ssh-keygen -b 2048 -t rsa -f /etc/ssh/ssh_host_rsa_key -q -N ""

if [[ "${AUTHORIZED_KEYS}" != "" ]]; then
    mkdir -p /root/.ssh
    chmod 700 /root/.ssh
    echo "${AUTHORIZED_KEYS}" > /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
fi

exec /usr/sbin/sshd -D
