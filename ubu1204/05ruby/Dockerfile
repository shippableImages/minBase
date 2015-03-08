FROM shippable/min04base
MAINTAINER Avi "avi@shippable.com"

ENV DEBIAN_FRONTEND noninteractive

# setting up Ruby
ADD rubyInstaller.sh /home/shippable/setup/
RUN /bin/bash /home/shippable/setup/rubyInstaller.sh

# Upgrade jRuby to 1.7.13
ADD jRubyUpgrade.sh /home/shippable/setup/
RUN chown shippable:shippable /home/shippable/setup/jRubyUpgrade.sh && chmod +x /home/shippable/setup/jRubyUpgrade.sh && sudo su - shippable -c "/bin/bash /home/shippable/setup/jRubyUpgrade.sh"

# add gemrc file to shippable HOME
ADD gemrc /home/shippable/.gemrc
RUN chown shippable:shippable /home/shippable/.gemrc

# expose port 22 to enable ssh 
EXPOSE 22
