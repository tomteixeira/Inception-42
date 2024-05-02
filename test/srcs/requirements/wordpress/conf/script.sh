#!/bin/bash

sleep 6

check_connection() {
  mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -e "SELECT 1;" 2>/dev/null
}

# connect to db
while true; do
  echo "Trying to connect to MYSQL..."
  if check_connection >/dev/null 2>&1; then
    break
  fi
  sleep 1
done

echo "Connection successful."

if [ ! -d /var/www/html/wp-content ]; 
then
    cd /var/www/html
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
    wp core download --allow-root
    
    mv wp-config-sample.php wp-config.php && wp config set SERVER_PORT 3306 --allow-root

    wp config set DB_HOST 'mariadb:3306' --allow-root --path=/var/www/html
    wp config set DB_NAME $MYSQL_DATABASE --allow-root --path=/var/www/html
    wp config set DB_USER $MYSQL_USER --allow-root --path=/var/www/html
    wp config set DB_PASSWORD $MYSQL_PASSWORD --allow-root --path=/var/www/html


    wp core install --url=$DOMAIN_NAME --title=inception --admin_user=$ADMIN_USER --admin_password=$ADMIN_PSWD --admin_email=$ADMIN_EMAIL --allow-root
    wp user create $WP_USER $WP_EMAIL_USER --role=author --user_pass=$WP_PSWD_USER --allow-root --path=/var/www/html
else
        
    cd /var/www/html
    rm -rf *
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
    wp core download --allow-root
    
    mv wp-config-sample.php wp-config.php && wp config set SERVER_PORT 3306 --allow-root

    wp config set DB_HOST 'mariadb:3306' --allow-root --path=/var/www/html
    wp config set DB_NAME $MYSQL_DATABASE --allow-root --path=/var/www/html
    wp config set DB_USER $MYSQL_USER --allow-root --path=/var/www/html
    wp config set DB_PASSWORD $MYSQL_PASSWORD --allow-root --path=/var/www/html

    wp core install --url=$DOMAIN_NAME --title=inception --admin_user=$ADMIN_USER --admin_password=$ADMIN_PSWD --admin_email=$ADMIN_EMAIL --allow-root
    wp user create $WP_USER $WP_EMAIL_USER --role=author --user_pass=$WP_PSWD_USER --allow-root --path=/var/www/html

fi

echo "Wordpress start"
php-fpm7.4 -F