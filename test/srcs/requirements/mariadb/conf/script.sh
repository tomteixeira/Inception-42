#!/bin/sh

service mariadb start

# Create and import WordPress database
mariadb -u root -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mariadb -u root -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mariadb -u root -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
mariadb -u root -e "FLUSH PRIVILEGES;"

# Import database dump
# mariadb -u root $MYSQL_DATABASE < /usr/local/bin/dump.sql

# Set password for root user
mariadb -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MYSQL_ROOT_PASSWORD');"
mariadb -u root -e "FLUSH PRIVILEGES;"

# Allow root user to login from any host
mariadb -u root -p $MYSQL_ROOT_PASSWORD "GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
mariadb -u root -p $MYSQL_ROOT_PASSWORD "FLUSH PRIVILEGES;"

service mariadb stop

mysqld

# service mysql start 


# echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE ;" > db1.sql
# echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> db1.sql
# echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' ;" >> db1.sql
# echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' ;" >> db1.sql
# echo "FLUSH PRIVILEGES;" >> db1.sql

# mysql < db1.sql

# kill $(cat /var/run/mysqld/mysqld.pid)

# echo "$MYSQL_DATABASE $MYSQL_USER $MYSQL_PASSWORD"

# mysqld

# if [ ! -d "/run/mysqld" ]; then
#     mkdir -p /run/mysqld
#     # Set the owner and group for the directory
#     chown mysql:mysql /run/mysqld
#     # Set the permissions for the directory to be more restrictive
#     chmod 750 /run/mysqld
# fi

# if [ ! -d "/var/lib/mysql/mysql" ]; then
#     chown -R mysql:mysql /var/lib/mysql
#     mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null
#     tfile=`mktemp`
#     if [ ! -f "$tfile" ]; then
#         return 1
#     fi
# 	cat << EOF > $tfile

# 	USE mysql;
#     FLUSH PRIVILEGES;
#     DELETE FROM mysql.user WHERE User='';
#     DROP DATABASE test;
#     DELETE FROM mysql.db WHERE Db='test';
#     DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
#     ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
#     CREATE DATABASE wordpress CHARACTER SET utf8 COLLATE utf8_general_ci;
#     CREATE USER '$MYSQL_USER'@'%' IDENTIFIED by '$MYSQL_PASSWORD';
#     GRANT ALL PRIVILEGES ON wordpress.* TO '$MYSQL_USER'@'%';
#     GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'mariadb' IDENTIFIED BY '$MYSQL_PASSWORD';
# 	FLUSH PRIVILEGES;
# EOF

#     mysqld --user=mysql --bootstrap < $tfile
# 	rm -f $tfile
# fi
# # sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
# # sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

# exec mysqld --user=mysql
