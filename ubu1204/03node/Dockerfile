FROM shippable/min02base
MAINTAINER Avi "avi@shippable.com"

ENV DEBIAN_FRONTEND noninteractive

# setting up Node
ADD nodeInstaller.sh /home/shippable/setup/
RUN /bin/bash /home/shippable/setup/nodeInstaller.sh

# expose port 22 to enable ssh 
EXPOSE 22
