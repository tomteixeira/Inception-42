FROM debian:bullseye

RUN apt update && apt upgrade
RUN apt-get install nginx openssl -y

COPY www/index.html /usr/share/nginx/html
COPY conf/nginx.conf /etc/nginx/conf.d

RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/ssl_toteixei.key \
    -out /etc/nginx/ssl/ssl_toteixei.crt \
    -subj "/C=FR/ST=Paris/L=Paris/O=42 Paris/CN=toteixei.42.fr"

EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]