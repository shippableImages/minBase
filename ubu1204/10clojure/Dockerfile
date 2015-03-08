FROM shippable/min09base
MAINTAINER Avi "avi@shippable.com"

ENV DEBIAN_FRONTEND noninteractive

ADD clojureInstaller.sh /home/shippable/setup/
RUN /bin/bash /home/shippable/setup/clojureInstaller.sh


# expose port 22 to enable ssh
EXPOSE 22
