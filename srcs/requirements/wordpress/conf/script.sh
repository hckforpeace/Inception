sleep 10
# will create the file wp-config.php and connect wordpress to the database using the db 
wp config create	--allow-root \
			--dbname=$SQL_DATABASE 
			--dbuser=$SQL_USER \
			--dbpass=$SQL_PASSWORD \
			--dbhost=mariadb:3306 --path='/var/www/wordpress'
