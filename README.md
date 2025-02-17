# Wordpress-Automation
<h1 align="left">Setup Ubuntu and Install LAMP Stack</h1>

   ```sh
sudo apt update && sudo apt upgrade -y
   ```
   
   ```sh
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
   ```

   ```sh
sudo chown -R www-data:www-data /var/www/local.example.com
   ```

   ```sh
sudo chmod -R 755 /var/www/local.example.com
   ```

<h3 align="left">Create virtual host config:</h3>

   ```sh
sudo nano /etc/apache2/sites-available/local.example.com.conf
   ```

<h3 align="left">Virtual Host Config File:</h3>

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
   ```
   ```sh
sudo systemctl reload apache2
   ```

<h1 align="left">WordPress Installation:</h1>

<h3 align="left">Download & Install WordPress:</h3>

   ```sh
cd /tmp && wget https://wordpress.org/latest.tar.gz
   ```
   ```sh
tar -xzvf latest.tar.gz
   ```
   ```sh
sudo cp -r wordpress/* /var/www/local.example.com/public_html/
   ```
   ```sh
sudo chown -R www-data:www-data /var/www/local.example.com/public_html
   ```

<h3 align="left">Create MySQL Database:</h3>

   ```sh
sudo mysql -u root -p
   ```

<h3 align="left">Commands to create MySQL Database:</h3>


   ```sh
CREATE DATABASE wp_example_db;
   ```
   ```sh
CREATE USER 'wp_example_user'@'localhost' IDENTIFIED BY 'your_password';
   ```
   ```sh
GRANT ALL PRIVILEGES ON wp_example_db.* TO 'wp_example_user'@'localhost';
   ```
   ```sh
FLUSH PRIVILEGES;
   ```
   ```sh
EXIT;
   ```

<h3 align="left">Configure wp-config.php:</h3>

   ```sh
cd /var/www/local.example.com/public_html
   ```
   ```sh
sudo cp wp-config-sample.php wp-config.php
   ```
   ```sh
sudo nano wp-config.php
   ```

<h3 align="left">Update the following in above wp-config.php:</h3>

   ```sh
define('DB_NAME', 'wp_example_db'); #with your own Database Name
define('DB_USER', 'wp_example_user'); #with your username
define('DB_PASSWORD', 'your_password'); #with your password
   ```

<h1 align="left">Update /etc/hosts</h1>

   ```sh
sudo nano /etc/hosts
   ```

<h3 align="left">Add:</h3>

   ```sh
127.0.0.1   local.example.com
   ```

<h3 align="left">Test with:</h3>

   ```sh
curl http://local.example.com
   ```

<h1 align="left">Automate WordPress Setup with WP-CLI:</h1>

<h3 align="left">Install WP-CLI:</h3>

   ```sh
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
   ```
   ```sh
chmod +x wp-cli.phar
   ```
   ```sh
sudo mv wp-cli.phar /usr/local/bin/wp
   ```

<h3 align="left">Create automation script:</h3>

   ```sh
sudo nano /usr/local/bin/wp-automate.sh
   ```

<h3 align="left">Script:</h3>

   ```sh
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
   ```

<h3 align="left">Make script executable:</h3>

   ```sh
sudo chmod +x /usr/local/bin/wp-automate.sh
   ```

<h3 align="left">Test the Script:</h3>

   ```sh
sudo wp-automate.sh local.test.com
   ```

<h3 align="left">Verify with:</h3>

   ```sh
curl http://local.test.com
   ```

<h1 align="left">Web Form for Custom Domain:</h1>

<h3 align="left">Create HTML form:</h3>

   ```sh
sudo nano /var/www/html/form.html
   ```

<h3 align="left">HTML form:</h3>

   ```sh
<!DOCTYPE html>
<html>
<head>
    <title>Domain Setup</title>
</head>
<body>
    <form action="/setup.php" method="POST">
        <input type="text" name="domain" placeholder="Enter domain (e.g., test)">
        <input type="submit" value="Submit">
    </form>
</body>
</html>
   ```

<h3 align="left">Create PHP script:</h3>

   ```sh
sudo nano /var/www/html/setup.php
   ```

<h3 align="left">Script:</h3>

   ```sh
<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $domain = 'local.' . $_POST['domain'] . '.com';
    $output = shell_exec("sudo /usr/local/bin/wp-automate.sh $domain 2>&1");
    echo "<pre>$output</pre>";
}
?>
```

<h3 align="left">Allow Apache to run the script without a password:</h3>

   ```sh
sudo visudo
   ```

<h3 align="left">Add this line:</h3>

   ```sh
www-data ALL=(ALL) NOPASSWD: /usr/local/bin/wp-automate.sh
   ```

<h3 align="left">Test the HTML form:</h3>

   ```sh
curl http://127.0.0.1/form.html
   ```

<h3 align="left">Post Custom Domain Request to the above HTML form:</h3>

   ```sh
curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "domain=testdomain" http://127.0.0.1/setup.php
   ```
Plese your custom domain int the place of "testdomain"
