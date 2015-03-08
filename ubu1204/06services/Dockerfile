FROM shippable/min05base
MAINTAINER Avi "avi@shippable.com"

ENV DEBIAN_FRONTEND noninteractive

# setting up services
ADD serviceInstaller.sh /home/shippable/setup/
RUN /bin/bash /home/shippable/setup/serviceInstaller.sh

# service config
ADD mongodb.conf /etc/mongodb.conf
ADD redis.conf /etc/redis/redis.conf
ADD pg_hba.conf /etc/postgresql/9.2/main/pg_hba.conf
ADD postgresql.conf /etc/postgresql/9.2/main/postgresql.conf
ADD my.cnf /etc/mysql/my.cnf

# Configure POSTGRE
ADD pg.sh /home/shippable/setup/
ADD pg9_1.sh /home/shippable/setup/
ADD pg9_3.sh /home/shippable/setup/
ADD pg.sql /home/shippable/setup/

ADD pg_hba.conf /etc/postgresql/9.1/main/pg_hba.conf
ADD pg_hba.conf /etc/postgresql/9.2/main/pg_hba.conf
ADD pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf

RUN /bin/bash /home/shippable/setup/pg.sh;\
    chown -cR root:root /etc/postgresql/9.2/main/postgresql.conf;\
    chown -cR root:root /etc/postgresql/9.2/main/pg_hba.conf;

RUN /bin/bash /home/shippable/setup/pg9_1.sh;\
    chown -cR postgres:postgres /etc/postgresql/9.1/main/;

RUN /bin/bash /home/shippable/setup/pg9_3.sh;\
    chown -cR postgres:postgres /etc/postgresql/9.3/main/;

# Config MYSQL
ADD upgradeMysql.sh /home/shippable/setup/
ADD mysql.sh /home/shippable/setup/

RUN /bin/bash  /home/shippable/setup/upgradeMysql.sh;\
    /bin/bash /home/shippable/setup/mysql.sh;\
    chmod +x /etc/init.d/xvfb;\
    chown -cR root:root /etc/mongodb.conf;\
    chown -cR root:root /etc/redis/redis.conf;

# expose port 22 to enable ssh 
EXPOSE 22
