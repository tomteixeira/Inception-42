FROM    debian:bullseye

RUN     apt update && apt install -y \
         mariadb-server \
         mariadb-client\
         procps

RUN     mkdir -p /var/lib/mysql /var/run/mysqld

RUN     rm /etc/mysql/mariadb.conf.d/50-server.cnf
COPY    conf/50-server.cnf	/etc/mysql/mariadb.conf.d/
RUN		chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf

RUN			echo "\n[mariadb]\nbind-address=0.0.0.0\nport=3306\n" >>/etc/mysql/my.cnf

COPY	conf /tmp/
RUN		chmod a+x /tmp/script.sh

RUN     chown -R mysql:mysql /var/run/mysqld
RUN     chown -R mysql:mysql /var/lib/mysql
RUN     chmod 777 /var/run/mysqld

RUN     /tmp/script.sh

EXPOSE 3306

ENTRYPOINT ["mysqld_safe"]
#
#FROM alpine:3.18.3
#
#RUN apk update && apk add mariadb mariadb-client
#
#COPY ./conf/my.cnf /etc/my.cnf
#COPY ./conf/mariadb_server.cnf /etc/my.cnf.d/mariadb-server.cnf
#COPY conf/install.sh .
#
#
#RUN chmod +x install.sh
#
#CMD ["./install.sh"]