FROM shippabledev/ubuntu:12.04
MAINTAINER Avi "avi@shippable.com"

ENV DEBIAN_FRONTEND noninteractive

# setting up ROOT shippable user
RUN useradd -d /home/shippable -m -s /bin/bash -p shippablepwd shippable;\
    echo 'export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' >> /home/shippable/.bashrc;\
    mkdir -p /home/shippable/.ssh;\
    mkdir -p /home/shippable/wrk;\
    mkdir -p /home/shippable/config;\
    mkdir -p /home/shippable/logs;\
    mkdir -p /home/shippable/ve;\
    echo 'shippable ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers;\
    chown -cR shippable:shippable /home/shippable/;\
    mkdir -p /usr/local/share;\
    mkdir -p /var/run/sshd;

# add profiles
ADD .bash_profile /home/shippable/

ADD gbl_env.sh /etc/profile.d/

ADD .bash_profile /home/shippable/
ADD config /home/shippable/.ssh/

# force all apt-get commands with a yes
ADD 90forceyes /etc/apt/apt.conf.d/
ADD xvfb.sh /etc/init.d/xvfb

# adding permissions
RUN chmod -c 750 /home/shippable ;\
    chown -cR shippable:shippable /home/shippable;\
    chmod -cR 744 /var/run/sshd;

ADD containerSetup.sh /home/shippable/setup/
RUN /bin/bash /home/shippable/setup/containerSetup.sh

# expose port 22 to enable ssh 
EXPOSE 22
