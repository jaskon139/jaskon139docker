FROM       ubuntu:14.04
MAINTAINER Aleksandar Diklic "https://github.com/rastasheep"

RUN apt-get update

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

EXPOSE 22

RUN npm install http-proxy

ADD proxy.js /proxy.js
ADD defaultSites.json /defaultSites.json

ENTRYPOINT ["node", "proxy.js"]

CMD    ["/usr/sbin/sshd", "-D"]


EXPOSE 80
