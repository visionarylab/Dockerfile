FROM davidcaste/alpine-tomcat:jdk8tomcat7

MAINTAINER lyc <imyikong@gmail.com>

ADD entry.sh /entry.sh
ADD build.sh /build.sh

ENV DOCKER_DEBUG 0
ENV SOURCE_DIR /src
ENV INDEX_DELAY 30
ENV GIT_SOURCE ""
ENV TAR_SOURCE ""
ENV TGZ_SOURCE ""
ENV ZIP_SOURCE ""

ENV OPENGROK_INSTANCE_BASE /var/opengrok
ENV OPENGROK_TOMCAT_BASE /opt/tomcat

EXPOSE 8080

WORKDIR /

RUN ["/build.sh"]

ENTRYPOINT ["/entry.sh"]
