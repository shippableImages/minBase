FROM shippable/min07base
MAINTAINER Avi "avi@shippable.com"

ENV DEBIAN_FRONTEND noninteractive

# setting up PHP
ADD phpInstaller.sh /home/shippable/setup/
RUN /bin/bash /home/shippable/setup/phpInstaller.sh

# This installs all the default PHP extensions using pecl
RUN mkdir -p /home/shippable/setup && chown shippable:shippable /home/shippable/setup
ADD phpInstallExtensions.sh /home/shippable/setup/phpInstallExtensions.sh
RUN sudo su - shippable -c ". /home/shippable/setup/phpInstallExtensions.sh"


# This installs composer and phpunit in each phpenv
RUN mkdir -p /home/shippable/setup && chown shippable:shippable /home/shippable/setup
ADD phpInstallBasePackages.sh /home/shippable/setup/phpInstallBasePackages.sh
RUN sudo su - shippable -c ". /home/shippable/setup/phpInstallBasePackages.sh"

# This installs HHVM
ADD phpHHVMInstaller.sh /home/shippable/setup/phpHHVMInstaller.sh
RUN sudo su - shippable -c ". /home/shippable/setup/phpHHVMInstaller.sh"

# restore phpini config files
ADD restorePHPini.sh /home/shippable/setup/restorePHPini.sh
RUN /bin/bash /home/shippable/setup/restorePHPini.sh

ADD fixPDOMySQLDefaultSocket.sh /home/shippable/fixPDOMySQLDefaultSocket.sh
RUN /bin/bash /home/shippable/fixPDOMySQLDefaultSocket.sh

# expose port 22 to enable ssh 
EXPOSE 22
