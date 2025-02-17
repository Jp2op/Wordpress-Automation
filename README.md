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

<h3 align="left">Configure Apache Virtual Hosts</h3>

   ```sh
sudo mkdir -p /var/www/local.example.com/public_html
sudo chown -R www-data:www-data /var/www/local.example.com
sudo chmod -R 755 /var/www/local.example.com
   ```
