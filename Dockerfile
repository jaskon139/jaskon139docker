FROM       ubuntu:14.04
MAINTAINER Aleksandar Diklic "https://github.com/rastasheep"

RUN apt-get update

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config


RUN apt-get update 

RUN apt-get install -y gcc make

RUN wget http://www.nocrew.org/software/httptunnel/httptunnel-3.0.5.tar.gz 

RUN gunzip httptunnel-3.0.5.tar.gz && tar xvf httptunnel-3.0.5.tar  

RUN cd httptunnel-3.0.5 && ./configure && make && make install  

ADD https://github.com/jaskon139/jaskon139docker/raw/master/autorun.sh /bin/autorun.sh
RUN chmod 777 /bin/autorun.sh

RUN apt-get install -y miredo

# update the base image
RUN apt-get update
RUN apt-get install apt-utils -y
RUN apt-get upgrade -y

# install Apache HTTPD
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2
RUN apt-get -y install ssl-cert apache2=2.4.7-* apache2-utils=2.4.7-*
RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2enmod headers
RUN a2dissite 000-default

# install Apache HTTPD mod_security
RUN apt-get -y install libapache2-modsecurity modsecurity-crs
RUN a2enmod security2
RUN cp /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf

WORKDIR /

# cleanup some unwanted packages
RUN apt-get -y autoremove

CMD ["-X"]

EXPOSE 80

CMD ["/bin/autorun.sh"]
