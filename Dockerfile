FROM clue/polipo

ADD https://raw.githubusercontent.com/jaskon139/jaskon139docker/master/config.sample  /etc/polipo/config.asmple

RUN mv /etc/polipo/config.asmple /etc/polipo/config

CMD ["nohup   polipo  "]
