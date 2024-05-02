FROM debian:bullseye

RUN apt update && apt upgrade && apt install -y \
    mariadb-server

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/.

COPY conf/script.sh .
RUN chmod +x script.sh
RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

EXPOSE 3306

CMD ["./script.sh"]