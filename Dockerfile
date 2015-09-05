FROM centos:centos6
MAINTAINER Takahiro Yano <speg03@gmail.com>

RUN yum install -y openssh-server sudo

RUN useradd docker

WORKDIR /home/docker

RUN mkdir .ssh
RUN chown -R docker:docker . && chmod 0700 .ssh && chmod 0600 .ssh/*

RUN echo "docker  ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers.d/docker

RUN /etc/init.d/sshd start
RUN /etc/init.d/sshd stop

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
