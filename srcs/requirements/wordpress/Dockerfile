# pull base image
FROM debian:bullseye

# update and upgrade system
RUN  apt-get update -y && apt-get upgrade -y

# isntall the required packages
RUN apt-get install -y\
            php\
            php7.4\
            curl\
						php-fpm\
						php-mysql\
						mariadb-client

COPY ./conf/wp_conf.sh /

RUN chmod +x wp_conf.sh

ENTRYPOINT [ "./wp_conf.sh" ]

