#Description: Nginx Dockerfile

#pull base image
FROM debian:bullseye

# update and upgrade the sytem
RUN apt-get update && apt-get upgrade -y

# # install openssl to create TLS certificate, and nginx server
RUN apt-get install -y nginx openssl

# create the ssl directory
RUN mkdir -p /etc/nginx/ssl

# create the ssl certificate
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout \
    /etc/nginx/ssl/inception.key -subj "/C=MO/ST=KH/L=KH/O=42/OU=42/CN=domain_name.fr/UID=admin_name"
# copy configuration file into the nginx container 
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# create the wordpress directory
RUN mkdir -p /var/www/wordpress

# create the wordpress directory
RUN chown -R www-data:www-data /var/www/wordpress

# define the command to run when container starts
ENTRYPOINT ["nginx", "-g", "daemon off;"]
