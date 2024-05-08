#!/bin/bash

# sleep 6

# check_connection() {
#   mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -e "SELECT 1;" 2>/dev/null
# }

# # connect to db
# while true; do
#   echo "Trying to connect to MYSQL..."
#   if check_connection >/dev/null 2>&1; then
#     break
#   fi
#   sleep 1
# done

# echo "Connection successful."

# if [ ! -d /var/www/html/wp-content ]; 
# then
#     cd /var/www/html
#     curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#     chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
#     wp core download --allow-root
    
#     mv wp-config-sample.php wp-config.php && wp config set SERVER_PORT 3306 --allow-root

#     wp config set DB_HOST 'mariadb:3306' --allow-root --path=/var/www/html
#     wp config set DB_NAME $MYSQL_DATABASE --allow-root --path=/var/www/html
#     wp config set DB_USER $MYSQL_USER --allow-root --path=/var/www/html
#     wp config set DB_PASSWORD $MYSQL_PASSWORD --allow-root --path=/var/www/html


#     wp core install --url=$DOMAIN_NAME --title=inception --admin_user=$ADMIN_USER --admin_password=$ADMIN_PSWD --admin_email=$ADMIN_EMAIL --allow-root
#     wp user create $WP_USER $WP_EMAIL_USER --role=author --user_pass=$WP_PSWD_USER --allow-root --path=/var/www/html
# else
        
#     cd /var/www/html
#     rm -rf *
#     curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#     chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
#     wp core download --allow-root
    
#     mv wp-config-sample.php wp-config.php && wp config set SERVER_PORT 3306 --allow-root

#     wp config set DB_HOST 'mariadb:3306' --allow-root --path=/var/www/html
#     wp config set DB_NAME $MYSQL_DATABASE --allow-root --path=/var/www/html
#     wp config set DB_USER $MYSQL_USER --allow-root --path=/var/www/html
#     wp config set DB_PASSWORD $MYSQL_PASSWORD --allow-root --path=/var/www/html

#     wp core install --url=$DOMAIN_NAME --title=inception --admin_user=$ADMIN_USER --admin_password=$ADMIN_PSWD --admin_email=$ADMIN_EMAIL --allow-root
#     wp user create $WP_USER $WP_EMAIL_USER --role=author --user_pass=$WP_PSWD_USER --allow-root --path=/var/www/html

# fi

# echo "Wordpress start"
# php-fpm7.4 -F

# Download and extract WordPress
wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
mkdir -p /var/www/html/
mv wordpress/* /var/www/html/
rm -rf latest.tar.gz

# Change ownership of WordPress files
chown -R www-data:www-data /var/www/html/

# Download wp-cli directly to the user's bin directory
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp
chmod +x /usr/local/bin/wp

# Configure WordPress
mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
wp config set DB_NAME $MYSQL_DATABASE --allow-root --path=/var/www/html/
wp config set DB_USER $MYSQL_USER --allow-root --path=/var/www/html/
wp config set DB_PASSWORD $MYSQL_PASSWORD --allow-root --path=/var/www/html/
wp config set DB_HOST mariadb --allow-root --path=/var/www/html/

while ! wp db check --allow-root --path=/var/www/html/; do
    echo "Waiting for Database to be ready..."
    echo "$MYSQL_DATABASE $MYSQL_USER $MYSQL_PASSWORD"
    sleep 1
done

# Start php-fpm
php-fpm -F