FROM debian:buster

RUN apt update -y && apt upgrade -y

RUN apt install mariadb-server -y


# Copying cinfiguration file
COPY conf/mysql.cnf /etc/mysql/conf.d/mysql.cnf

COPY conf/script.sh /root


# CMD ["bash", "script.sh"]

