FROM forumi0721/alpine-x64-base:latest

MAINTAINER lyc <imyikong@gmail.com>

ADD entry.sh /entry.sh
ADD build.sh /build.sh

RUN ["/build.sh"]

EXPOSE 80/tcp

VOLUME ["/data"]

ENTRYPOINT ["/entry.sh"]

