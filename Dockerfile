FROM tutum/centos:centos7

MAINTAINER lyc <imyikong@gmail.com>

ADD entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]
