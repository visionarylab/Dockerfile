#!/bin/sh

if [[ "${DOCKER_DEBUG}" == "1" ]]; then
    set -x
fi

exec client \
    --localaddr "${LOCALADDR}" \
    --remoteaddr "${REMOTEADDR}" \
    --mode "${MODE}" \
    --conn "${CONN}" \
    --autoexpire "${AUTOEXPIRE}" \
    --mtu "${MTU}" \
    --sndwnd "${SNDWND}" \
    --rcvwnd "${RCVWND}" \
    --dscp "${DSCP}"
