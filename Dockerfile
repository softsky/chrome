FROM ubuntu:14.04

MAINTAINER Tomohisa Kusano <siomiz@gmail.com>

ENV CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES 1024x768

COPY copyables /

ADD https://dl.google.com/linux/linux_signing_key.pub /tmp/

RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash \
    && nvm install node 5.0 \
    && nvm use node 5.0 \
    apt-key add /tmp/linux_signing_key.pub \
	&& apt-get update \
	&& apt-get install -y \
	g++ \
	make \
	google-chrome-stable \
	chrome-remote-desktop \
	fonts-takao \
	pulseaudio \
	supervisor \
	x11vnc \
	&& apt-get clean \
	&& rm -rf /var/cache/* /var/log/apt/* /tmp/* \
	&& addgroup chrome-remote-desktop \
	&& useradd -m -G chrome-remote-desktop,pulse-access chrome \
	&& ln -s /crdonly /usr/local/sbin/crdonly \
	&& ln -s /update /usr/local/sbin/update \
	&& ln -s /update /etc/cron.hourly/update

VOLUME ["/home/chrome"]

EXPOSE 5900

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
