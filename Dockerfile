FROM debian:testing
MAINTAINER Christian Lück <christian@lueck.tv>

RUN apt-get update && apt-get install -y polipo

ADD https://raw.githubusercontent.com/jaskon139/jaskon139docker/master/config.sample  /etc/polipo/config.asmple

RUN mv /etc/polipo/config.asmple /etc/polipo/config

EXPOSE 8123
ENTRYPOINT ["polipo"]
CMD []


