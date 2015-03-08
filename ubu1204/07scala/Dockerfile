FROM shippable/min06base
MAINTAINER Avi "avi@shippable.com"

ENV DEBIAN_FRONTEND noninteractive

# setting up Scala
ADD scalaInstaller.sh /home/shippable/setup/
RUN /bin/bash /home/shippable/setup/scalaInstaller.sh

# expose port 22 to enable ssh 
EXPOSE 22
