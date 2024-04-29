FROM debian:bullseye

RUN apt update && apt upgrade -y
RUN apt install -y mariadb-server

COPY conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf