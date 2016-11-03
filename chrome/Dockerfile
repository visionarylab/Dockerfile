FROM ubuntu:14.04

MAINTAINER lyc <imyikong@gmail.com>

ENV CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES 1024x768
ENV VNC_PASSWD admin
ENV VNC_WIDTH 1024
ENV VNC_HEIGHT 768
ENV VNC_COLOR 24
ENV VNC_WAIT 5

COPY copyables /

ADD https://dl.google.com/linux/linux_signing_key.pub /tmp/

RUN apt-key add /tmp/linux_signing_key.pub \
	&& apt-get update \
	&& apt-get install -y \
	google-chrome-stable \
	chrome-remote-desktop \
    fonts-droid ttf-wqy-zenhei ttf-wqy-microhei fonts-arphic-ukai fonts-arphic-uming \
	pulseaudio \
	supervisor \
	x11vnc \
	&& apt-get clean \
	&& rm -rf /var/cache/* /var/log/apt/* /tmp/* \
	&& addgroup chrome-remote-desktop \
	&& useradd -m -G chrome-remote-desktop,pulse-access chrome \
	&& ln -s /crdonly /usr/local/sbin/crdonly \
	&& ln -s /update /usr/local/sbin/update \
	&& ln -s /update /etc/cron.hourly/update \
	&& mkdir -p /home/chrome/.config/chrome-remote-desktop \
	&& chown -R chrome:chrome /home/chrome/.config

VOLUME ["/home/chrome"]

EXPOSE 5900

ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-c", "/etc/supervisor/conf.d/supervisord.conf"]
