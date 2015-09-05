FROM centos:latest
RUN yum -y install openssh openssh-clients openssh-server
EXPOSE 22
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
RUN ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
RUN echo "root:jump" | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


RUN yum -y install haproxy

# Disable daemon mode for default command
RUN sed --in-place 's/daemon/# daemon/' /etc/haproxy/haproxy.cfg

# Turn off default configuration
RUN mv /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.off

# Install launcher
ADD launch.sh /usr/local/sbin/
RUN chmod a+x /usr/local/sbin/launch.sh


CMD ["/usr/sbin/sshd", "-D"]
