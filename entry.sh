#!/bin/sh

if [ "${DOCKER_DEBUG}" == "1" ]; then
    set -x
fi

USER_NAME=${USER_NAME}
USER_PASSWD=$([ ! -z "${USER_EPASSWD}" ] && echo ${USER_EPASSWD} | base64 -d 2>/dev/null || echo ${USER_PASSWD})
WEBDAV_SHARE=${WEBDAV_SHARE}

if [ "${1/f/F}" = "-F" -o ! -s /etc/apache2/htpasswd -o \( ! -z "${USER_NAME}" -a ! -z "${USER_PASSWD}" -a "$(df /etc/apache2/htpasswd)" = "$(df /)" \) ]; then
	USER_NAME=${USER_NAME:-sharing}
    if [ "${USER_PASSWD}" == "" ]; then
	    USER_PASSWD=${RANDOM}
        echo "random password:" ${USER_PASSWD}
    fi

	touch /tmp/htpasswd
	sed -i -e "/^${USER_NAME}:webdav:/d" /tmp/htpasswd
	echo "${USER_NAME}:webdav:$(echo -n "${USER_NAME}:webdav:${USER_PASSWD}" | md5sum | cut -d ' ' -f 1)" >> /tmp/htpasswd
	cat /tmp/htpasswd > /etc/apache2/htpasswd
	rm -rf /tmp/htpasswd
fi

if [ "${1/f/F}" = "-F" -o ! -s /etc/apache2/httpd.conf -o \( ! -z "${WEBDAV_SHARE}" -a "$(df /etc/apache2/httpd.conf)" = "$(df /)" \) ]; then
	WEBDAV_SHARE=${WEBDAV_SHARE:-/data}

	cat /usr/local/etc/httpd.conf > /tmp/httpd.conf
	sed -i -e "s@/data@${WEBDAV_SHARE}@g" /tmp/httpd.conf
	cat /tmp/httpd.conf > /etc/apache2/httpd.conf
	rm -rf /tmp/httpd.conf

	mkdir -p ${WEBDAV_SHARE}
fi

exec httpd -D FOREGROUND

