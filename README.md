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
