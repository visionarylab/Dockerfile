FROM alpine

MAINTAINER lyc <imyikong@gmail.com>

WORKDIR \
ADD entry.sh /entry.sh

ENV DOCKER_DEBUG 0
ENV LOCALADDR :12948
ENV REMOTEADDR 127.0.0.1:29900
ENV MODE fast
ENV CONN 1
ENV AUTOEXPIRE 0
ENV MTU 1350
ENV SNDWND 128
ENV RCVWND 1024
ENV DSCP 0

RUN set -x && \
    apk update && \
    apk add --no-cache go git && \
    go get github.com/xtaci/kcptun/client && \
    apk del go git && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/entry.sh"]
