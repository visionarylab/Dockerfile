#!/bin/sh

x11vnc -storepasswd "${VNC_PASSWD}" /root/.vnc/passwd
unset VNC_PASSWD

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
