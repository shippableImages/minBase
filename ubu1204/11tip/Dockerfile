FROM shippable/min10base
MAINTAINER Avi "avi@shippable.com"

ENV DEBIAN_FRONTEND noninteractive

ADD updateMysqlPath.sh /home/shippable/setup/
RUN /bin/bash /home/shippable/setup/updateMysqlPath.sh

# add updated my.cnf
ADD my.cnf /etc/mysql/my.cnf

# add updated pg_hba.conf to all postgres versions
ADD pg_hba.conf /etc/postgresql/9.1/main/pg_hba.conf
ADD pg_hba.conf /etc/postgresql/9.2/main/pg_hba.conf
ADD pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf

RUN chown -cR root:root /etc/postgresql/9.1/main/pg_hba.conf;
RUN chown -cR root:root /etc/postgresql/9.2/main/pg_hba.conf;
RUN chown -cR root:root /etc/postgresql/9.3/main/pg_hba.conf;

# add fix permissions for .ssh directory
RUN chmod -cR 600 /home/shippable/.ssh/*

# Upgrade rvm to support ruby 2.2 stable
ADD upgradeRvm.sh /home/shippable/setup/upgradeRvm.sh
RUN /bin/bash /home/shippable/setup/upgradeRvm.sh

# Install appbase deps
ADD add_ds_deps.sh /home/shippable/setup/add_ds_deps.sh
RUN /bin/bash /home/shippable/setup/add_ds_deps.sh

# expose port 22 to enable ssh
EXPOSE 22
