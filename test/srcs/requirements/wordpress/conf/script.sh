#!/bin/bash

wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
mkdir -p /var/www/html/
mv wordpress/* /var/www/html/
rm -rf latest.tar.gz

chown -R root:root /var/www/html/

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp
chmod +x /usr/local/bin/wp

mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
wp config set DB_NAME $MYSQL_DATABASE --allow-root --path=/var/www/html/
wp config set DB_USER $MYSQL_USER --allow-root --path=/var/www/html/
wp config set DB_PASSWORD $MYSQL_PASSWORD --allow-root --path=/var/www/html/
wp config set DB_HOST mariadb:3306 --allow-root --path=/var/www/html/
wp core install --url=$DOMAIN_NAME --title=inception --admin_user=$ADMIN_USER --admin_password=$ADMIN_PSWD --admin_email=$ADMIN_EMAIL --allow-root --path=/var/www/html
wp user create $WP_USER $WP_EMAIL_USER --role=author --user_pass=$WP_PSWD_USER --allow-root --path=/var/www/html

while ! wp db check --allow-root --path=/var/www/html/; do
    echo "Waiting for Database to be ready..."
    echo "$MYSQL_DATABASE $MYSQL_USER $MYSQL_PASSWORD"
    sleep 1
done

php-fpm7.4 -F

