FROM alpine:latest

MAINTAINER lyc <imyikong@gmail.com>

RUN apk update && \
    apk add bash openssh-client

CMD ["bash"]
