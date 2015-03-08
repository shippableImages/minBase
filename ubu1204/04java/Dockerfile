FROM shippable/min03base
MAINTAINER Avi "avi@shippable.com"

ENV DEBIAN_FRONTEND noninteractive

# setting up Java
ADD javaInstaller.sh /home/shippable/setup/
RUN /bin/bash /home/shippable/setup/javaInstaller.sh

# expose port 22 to enable ssh 
EXPOSE 22
