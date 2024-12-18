# syntax=docker/dockerfile:1

FROM debian:bullseye

RUN apt update && apt upgrade

RUN apt install openssl

RUN	apt install nginx -y

RUN	apt install vim -y

#COPY conf/nginx.conf /etc/nginx/nginx.conf