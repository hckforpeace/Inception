FROM debian:buster

RUN apt update -y && apt upgrade -y

RUN apt install vim -y

RUN apt install mariadb-server-10.3 -y

COPY conf/script.sh /root

CMD ["bash", "/root/script.sh"]
