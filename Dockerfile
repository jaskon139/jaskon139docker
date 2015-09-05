FROM clue/polipo

RUN cp https://raw.githubusercontent.com/jaskon139/jaskon139docker/master/config.sample  /etc/polipo/config

CMD ["nohup   polipo  "]
