FROM ubuntu:14.04
RUN apt-get update && apt-get clean
RUN apt-get install -y squid3 && apt-get clean
#ADD squid.conf /etc/squid3/squid.conf
RUN mkdir /var/cache/squid
RUN chown proxy:proxy /var/cache/squid
RUN /usr/sbin/squid3 -N -z -F

EXPOSE 3128

CMD /usr/sbin/squid3 -N -d 0

RUN apt-get update && apt-get install -y openssh-server

RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

# public key
RUN mkdir /root/.ssh

ADD id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 0700 /root/.ssh
RUN chmod 0400 /root/.ssh/authorized_keys

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
