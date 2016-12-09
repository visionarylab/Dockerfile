FROM alpine

MAINTAINER lyc <imyikong@gmail.com>

ADD build.sh /build.sh
ADD entry.sh /entry.sh

ENV DOCKER_DEBUG 0
ENV AUTHORIZED_KEYS ""

EXPOSE 22

WORKDIR /root
RUN ["/build.sh"]

ENTRYPOINT ["/entry.sh"]
