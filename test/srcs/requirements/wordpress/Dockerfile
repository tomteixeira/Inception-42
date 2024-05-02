FROM debian:bullseye

RUN apt update && apt upgrade && apt install -y \
        php \
        mariadb-client \
        php-fpm \
        php-mysqli \
        php-mysql \
        curl

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/.

EXPOSE 9000

RUN mkdir -p /run/php
RUN chmod +777 /run/php

COPY conf/script.sh .
RUN chmod +x script.sh

CMD ["./script.sh"]