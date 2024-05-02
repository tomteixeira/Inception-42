FROM debian:bullseye

RUN apt update && apt upgrade && apt install -y \
    mariadb-server mariadb-client

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/.

RUN mkdir /run/mysql
RUN mkdir /run/mysqld

COPY conf/script.sh .
RUN chmod +x script.sh

EXPOSE 3306

CMD ["./script.sh"]