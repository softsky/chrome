FROM ubuntu:15.04

MAINTAINER Tomohisa Kusano <siomiz@gmail.com>

ENV CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES 1024x768

COPY copyables /

ADD https://dl.google.com/linux/linux_signing_key.pub /tmp/

RUN apt-key add /tmp/linux_signing_key.pub \
	&& apt-get update \
	&& apt-get install -y \
	g++ \
	make \
	libx11-dev \
	libxtst-dev \
	libpng12-dev \
	google-chrome-stable \
	chrome-remote-desktop \
	fonts-takao \
	pulseaudio \
	supervisor \
	x11vnc \
	git \
	&& apt-get clean \
#	&& rm -rf /var/cache/* /var/log/apt/* /tmp/* \
	&& addgroup chrome-remote-desktop \
	&& useradd -m -G chrome-remote-desktop,pulse-access chrome \
	&& ln -s /crdonly /usr/local/sbin/crdonly \
	&& ln -s /update /usr/local/sbin/update \
	&& ln -s /update /etc/cron.daily/update \
	&& wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash \
	&& . ~/.bashrc \
	&& nvm install node 5.0 \
	&& nvm use node 5.1 \
	&& echo "Build done"
	

VOLUME ["/home/chrome"]

EXPOSE 5900

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
