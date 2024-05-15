FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y mariadb-server


EXPOSE 3306


COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools /var/www/

COPY ./tools/launch.sh .
# COPY ./tools/script.sh .
RUN chmod +x launch.sh

# RUN "./launch.sh"

# RUN service mariadb start && mariadb < /var/www/db.sql

CMD ["./launch.sh"]

# CMD ["./launch.sh"]
