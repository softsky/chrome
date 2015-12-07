FROM siomiz/chrome

MAINTAINER Arsen A. Gutsal <gutsal.arsen@softsky.com.ua>

ENV CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES 1024x768

RUN apt-get update
RUN apt-get install -y \
	g++ \
	make \
	libx11-dev \
	libxtst-dev \
	libpng12-dev \
	git
	
RUN	apt-get clean
RUN	rm -rf /var/cache/* /var/log/apt/* /tmp/*

RUN	wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash \
	&& . ~/.bashrc \
	&& nvm install node 5.0 \
	&& nvm alias default 5.1
RUN	echo "Build done"
	

VOLUME ["/home/chrome"]

EXPOSE 5900

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
