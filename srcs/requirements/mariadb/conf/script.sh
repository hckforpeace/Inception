# start mysql
sed '28s/.*/bind-address            = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf > /etc/mysql/mariadb.conf.d/temp_file && mv /etc/mysql/mariadb.conf.d/temp_file /etc/mysql/mariadb.conf.d/50-server.cnf

export db_name=mydb
export db_user=pierre
export db_pwd=234


service mysql start 
sleep 4
mysql -e "CREATE DATABASE IF NOT EXISTS $db_name ;"
mysql -e "CREATE USER IF NOT EXISTS '$db_user'@'%' IDENTIFIED BY '$db_pwd' ;"

mysql -e "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'%' ;"

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;"

mysql -u root -p'12345' -e "FLUSH PRIVILEGES;"

/usr/bin/mysqld_safe
