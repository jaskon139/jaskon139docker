FROM centos:latest
RUN yum -y install openssh openssh-clients openssh-server
EXPOSE 22
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
RUN ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
RUN echo "root:jump" | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN yum -y install squid

RUN chkconfig --level 35 squid on

RUN squid –z

RUN squid start

RUN yum -y install httpd

RUN chkconfig httpd on

#RUN httpd start

RUN chkconfig httpd on

RUN echo "<h1>Squid-Web1/localhost</h1>" > /var/www/html/index.html

EXPOSE 8000


CMD ["/usr/sbin/sshd", "-D"]
