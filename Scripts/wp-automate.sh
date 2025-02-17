#!/bin/bash
DOMAIN=$1
DB_NAME="wp_${DOMAIN}_db"
DB_USER="wp_${DOMAIN}_user"
DB_PASS="your_password"

# Create directory and virtual host
sudo mkdir -p /var/www/${DOMAIN}/public_html
sudo chown -R www-data:www-data /var/www/${DOMAIN}
sudo chmod -R 755 /var/www/${DOMAIN}

# Apache config
cat <<EOF | sudo tee /etc/apache2/sites-available/${DOMAIN}.conf
<VirtualHost 127.0.0.1:80>
    ServerAdmin admin@${DOMAIN}
    ServerName ${DOMAIN}
    DocumentRoot /var/www/${DOMAIN}/public_html
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

sudo a2ensite ${DOMAIN}.conf
sudo systemctl reload apache2

# MySQL setup
sudo mysql -u root -p"your_mysql_root_password" <<MYSQL_SCRIPT
CREATE DATABASE ${DB_NAME};
CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# Install WordPress
sudo -u www-data wp core download --path=/var/www/${DOMAIN}/public_html
sudo -u www-data wp config create --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASS} --path=/var/www/${DOMAIN}/public_html
sudo -u www-data wp core install --url=${DOMAIN} --title="Site ${DOMAIN}" --admin_user=admin --admin_password=admin_password --admin_email=admin@${DOMAIN} --path=/var/www/${DOMAIN}/public_html

# Update /etc/hosts
echo "127.0.0.1   ${DOMAIN}" | sudo tee -a /etc/hosts
