FROM debian:bullseye

RUN apt update && apt install -y nginx openssl \
    && rm -rf /var/lib/apt/lists/*

RUN openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
    -keyout /etc/ssl/private/toteixei.key \
    -out /etc/ssl/certs/toteixei.cert \
    -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=toteixei/CN=toteixei/"

COPY conf/default /etc/nginx/sites-available/.

CMD ["nginx", "-g", "daemon off;"]