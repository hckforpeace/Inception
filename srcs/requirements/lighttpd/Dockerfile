FROM debian:bullseye

RUN apt-get update && apt-get upgrade 

RUN apt-get install lighttpd vim  -y

COPY ./conf/index.html /var/www/html

RUN sed -i 's/server.port                 = 80/server.port                 = 8081/g' /etc/lighttpd/lighttpd.conf

CMD ["lighttpd", "-D" ,"-f" ,"/etc/lighttpd/lighttpd.conf"]