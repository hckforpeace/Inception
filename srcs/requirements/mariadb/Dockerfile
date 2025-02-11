# pull base image
FROM debian:bullseye

# update and upgrade the system
RUN apt-get update -y && apt upgrade -y

# install packages
RUN apt-get install -y mariadb-server netcat

# copy files from host to container COPY ./conf/mdb-conf.sh /mdb-conf.sh
COPY /conf/mdb-conf.sh /mdb-conf.sh

# give execution permission for the configuration file
RUN chmod +x /mdb-conf.sh

# ENTRYPOINT to run at the start of a container
ENTRYPOINT ["bash", "/root/mdb-conf.sh"]
