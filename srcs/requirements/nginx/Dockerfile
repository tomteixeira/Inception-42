FROM debian:bullseye

RUN apt update && apt upgrade
RUN apt-get install nginx -y

COPY www/index.html /usr/share/nginx/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]