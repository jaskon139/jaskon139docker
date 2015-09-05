FROM ubuntu:14.04
RUN apt-get update && apt-get clean
RUN apt-get install -y squid3 && apt-get clean
ADD squid.conf /etc/squid3/squid.conf
RUN mkdir /var/cache/squid
RUN chown proxy:proxy /var/cache/squid
RUN /usr/sbin/squid3 -N -z -F

EXPOSE 3128

CMD /usr/sbin/squid3 -N -d 0

RUN apt-get update && apt-get install -y openssh openssh-client openssh-server
EXPOSE 22
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
RUN ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
RUN echo "root:jump" | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

CMD ["/usr/sbin/sshd", "-D"]
