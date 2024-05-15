#!/bin/bash

mysqld_safe &

sleep 3

mariadb -u root << EOF
CREATE DATABASE $DB_NAME;
CREATE USER $MYSQL_USER@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO $MYSQL_USER@'%';
FLUSH PRIVILEGES;
EOF

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"

mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

mysqld_safe

# echo $MYSQL_PASSWORD $MYSQL_USER $MYSQL_ROOT_PASSWORD

# echo "CREATE DATABASE IF NOT EXISTS wordpress;" > /var/www/db.sql
# echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> /var/www/db.sql
# echo "GRANT ALL PRIVILEGES ON wordpress.* TO '$MYSQL_USER'@'%';" >> /var/www/db.sql
# echo "FLUSH PRIVILEGES;" >> /var/www/db.sql
# echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> /var/www/db.sql

# service mariadb start && mariadb < /var/www/db.sql

# # service mariadb start && mariadb -h localhost -p$MYSQL_ROOT_PASSWORD < /var/www/db.sql

# mysqld