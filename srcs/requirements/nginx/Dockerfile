# syntax=docker/dockerfile:1

FROM debian:bullseye

RUN apt update && apt upgrade

RUN apt install openssl

RUN	apt install nginx -y

RUN	apt install curl -y

RUN	apt install vim -y

RUN mkdir /etc/nginx/ssl

RUN mkdir /var/www/html/custom

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr/UID=login"

RUN chmod 777 /var/www/html

RUN chown -R www-data:www-data /var/www/html

COPY conf/default /etc/nginx/sites-enabled/default

COPY conf/index.html /var/www/html/custom

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]