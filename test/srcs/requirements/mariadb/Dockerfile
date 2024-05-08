FROM    debian:bullseye

ARG         MYSQL_DATABASE
ARG         MYSQL_USER
ARG         MYSQL_PASSWORD
ARG         MYSQL_ROOT_PASSWORD

RUN     apt update && apt install -y \
         mariadb-server \
         mariadb-client\
         procps

RUN     mkdir -p /var/lib/mysql /var/run/mysqld

# RUN     rm /etc/mysql/mar/etciadb.conf.d/50-server.cnf
COPY    conf/mariadb.cnf	/etc/mysql/
RUN		chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf
COPY    conf/dump.sql /usr/local/bin/

# RUN			echo "\n[mariadb]\nbind-address=0.0.0.0\nport=3306\n" >>/etc/mysql/my.cnf

COPY	conf/script.sh .
RUN     chmod a+x script.sh
# RUN		chmod a+x /tmp/script.sh

RUN     chown -R mysql:mysql /var/run/mysqld
RUN     chown -R mysql:mysql /var/lib/mysql
RUN     chmod 777 /var/run/mysqld

# RUN     bash /usr/local/bin/script.sh

EXPOSE 3306



CMD ["./script.sh"]