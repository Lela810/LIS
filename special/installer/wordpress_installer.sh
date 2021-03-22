#!/bin/bash 


# Clear Current Screen
clear

# Check Session Status
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
elif [[ $EUID -eq 0 ]]; then
   echo -e "Session Running as \e[36mROOT\e[0m"
fi



#Download Premade Config Files
apt update -y
apt install wordpress php libapache2-mod-php mysql-server php-mysql -y

echo "Alias /blog /usr/share/wordpress
<Directory /usr/share/wordpress>
    Options FollowSymLinks
    AllowOverride Limit Options FileInfo
    DirectoryIndex index.php
    Order allow,deny
    Allow from all
</Directory>
<Directory /usr/share/wordpress/wp-content>
    Options FollowSymLinks
    Order allow,deny
    Allow from all
</Directory>" > /etc/apache2/sites-available/wordpress.conf


a2ensite wordpress
a2enmod rewrite
service apache2 reload

echo "CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS "wordpress"@"localhost" IDENTIFIED BY \"31Yxcvbnm\";
GRANT ALL PRIVILEGES ON databasename.* TO "wordpress"@"localhost";
FLUSH PRIVILEGES;" > wordpress.sql

mysql -u root < wordpress.sql
rm wordpress.sql


cd /usr/share/wordpress
chown www-data:www-data  -R * # Let Apache be owner
find . -type d -exec chmod 755 {} \;  # Change directory permissions rwxr-xr-x
find . -type f -exec chmod 644 {} \;  # Change file permissions rw-r--r--


echo ""
echo ""
echo ""
echo "Wordpress installed!"
echo ""
echo "MySQL:"
echo "	User: wordpress"
echo "	Password: 31Yxcvbnm"
echo ""
echo ""
echo ""