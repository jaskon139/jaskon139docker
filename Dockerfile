FROM       ubuntu:14.04
MAINTAINER Aleksandar Diklic "https://github.com/rastasheep"

RUN apt-get update

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN wget http://www.nocrew.org/software/httptunnel/httptunnel-3.0.5.tar.gz 

RUN gunzip httptunnel-3.0.5.tar.gz && tar xvf httptunnel-3.0.5.tar  

RUN apt-get update && apt-get install -y gcc && apt-get install -y make

RUN cd httptunnel-3.0.5 && ./configure && make && make install  

ADD https://github.com/jaskon139/jaskon139docker/raw/master/autorun.sh /bin/autorun.sh
RUN chmod 777 /bin/autorun.sh

EXPOSE 80

CMD ["/bin/autorun.sh"]
