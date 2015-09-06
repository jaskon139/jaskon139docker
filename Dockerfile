FROM rastasheep/ubuntu-sshd

RUN mkdir -p /tmp/httptunnel && cd /tmp/httptunnel && wget http://www.nocrew.org/software/httptunnel/httptunnel-3.0.5.tar.gz 

RUN gunzip httptunnel-3.0.5.tar.gz && tar xvf httptunnel-3.0.5.tar && cd httptunnel-3.0.5 

RUN apt-get install -y gcc

RUN ./configure && make && make install  

EXPOSE 80 22

CMD ["hts", "--forward-port 127.0.0.1:22 80"]
