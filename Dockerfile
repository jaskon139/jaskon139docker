FROM reddec/squid

RUN apt-get update && apt-get install -y openssh-server

RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

# public key
RUN mkdir /root/.ssh

ADD https://raw.githubusercontent.com/jaskon139/jaskon139docker/master/id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 0700 /root/.ssh
RUN chmod 0400 /root/.ssh/authorized_keys

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
