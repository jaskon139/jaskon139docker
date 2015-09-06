FROM rastasheep/ubuntu-sshd

RUN wget http://www.nocrew.org/software/httptunnel/httptunnel-3.0.5.tar.gz 

RUN gunzip httptunnel-3.0.5.tar.gz && tar xvf httptunnel-3.0.5.tar  

RUN apt-get update && apt-get install -y gcc && apt-get install -y make

RUN cd httptunnel-3.0.5 && ./configure && make && make install  

EXPOSE 80 22

CMD ["/usr/local/bin/hts --forward-port 127.0.0.1:22 80"]
