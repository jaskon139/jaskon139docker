FROM ubuntu:14.04
RUN apt-get update && \
    apt-get --yes install --no-install-recommends privoxy && \
    chown root:root /var/log/privoxy /etc/privoxy && \
    chmod 0700 /var/log/privoxy && \
    rm -rf /var/lib/apt/lists/*

VOLUME ["/etc/privoxy", "/var/log/privoxy"]
CMD ["/usr/sbin/privoxy", "--no-daemon", "/etc/privoxy/config"]

EXPOSE 8118


RUN apt-get install -y openssh openssh-clients openssh-server
EXPOSE 22
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
RUN ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
RUN echo "root:jump" | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

CMD ["/usr/sbin/sshd", "-D"]
