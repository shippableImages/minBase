FROM shippable/min01base
MAINTAINER Avi "avi@shippable.com"

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /home/shippable/packages

# setting up Python
ADD pythonInstaller.sh /home/shippable/setup/
RUN /bin/bash /home/shippable/setup/pythonInstaller.sh

# expose port 22 to enable ssh 
EXPOSE 22
