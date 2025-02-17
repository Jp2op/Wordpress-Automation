# Wordpress-Automation
<h1 align="left">Setup Ubuntu and Install LAMP Stack</h1>

   ```sh
sudo apt update && sudo apt upgrade -y
sudo apt install -y apache2 mysql-server php libapache2-mod-php php-mysql python3 nodejs npm
   ```

<h1 align="left">Install PHP Extensions</h1>

   ```sh
sudo apt install -y php-curl php-gd php-mbstring php-xml php-zip php-soap php-intl
   ```

<h1 align="left">Secure MySQL Installation</h1>
Follow prompts to set root password and secure settings
 
   ```sh
sudo mysql_secure_installation
   ```

<h1 align="left">Configure Apache Virtual Hosts</h1>

<h3 align="left">Create directories for local.example.com:</h3>

   ```sh
sudo mkdir -p /var/www/local.example.com/public_html
sudo chown -R www-data:www-data /var/www/local.example.com
sudo chmod -R 755 /var/www/local.example.com
   ```

<h3 align="left">File Content:</h3>

   ```sh
<VirtualHost 127.0.0.1:80>
    ServerAdmin admin@local.example.com
    ServerName local.example.com
    DocumentRoot /var/www/local.example.com/public_html
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
   ```

<h3 align="left">Enable the site and reload Apache:</h3>

   ```sh
sudo a2ensite local.example.com.conf
sudo systemctl reload apache2
   ```

<h1 align="left">Enable the site and reload Apache:</h1>

<h3 align="left">Download & Install WordPress:</h3>

   ```sh
cd /tmp && wget https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
sudo cp -r wordpress/* /var/www/local.example.com/public_html/
sudo chown -R www-data:www-data /var/www/local.example.com/public_html
   ```

<h3 align="left">Create MySQL Database:</h3

   ```sh
sudo mysql -u root -p
   ```

<h3 align="left">Commands to create MySQL Database:</h3


   ```sh
CREATE DATABASE wp_example_db;
CREATE USER 'wp_example_user'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON wp_example_db.* TO 'wp_example_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
   ```
