FROM debian:buster

RUN apt update -y && apt upgrade -y

RUN apt install vim -y

RUN apt install mariadb-server-10.3 -y


# Copying cinfiguration file
# COPY conf/mysql.cnf /etc/mysql/conf.d/mysql.cnf

COPY conf/script.sh /root


# CMD ["bash", "script.sh"]
