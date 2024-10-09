#!/bin/bash

echo "[Provision] Updating packages..."
sudo apt-get update

echo "[Provision] Installing Apache..."
sudo apt-get install -y apache2
apacheConfigPath="/etc/apache2/sites-available/000-default.conf"
if [ ! -f "$apacheConfigPath" ]; then
	echo "[Provision] Error: Apache configuration file not found at $apacheConfigPath"
	exit 1
fi
sudo sed -i '/<\/VirtualHost>/i \\n\t<Directory /var/www/html>\n\t\tAllowOverride All\n\t</Directory>' "$apacheConfigPath"
sudo a2enmod rewrite
sudo systemctl restart apache2

echo "[Provision] Installing PHP..."
sudo apt-get install -y php libapache2-mod-php php-xdebug phpunit
xdebugIniPath=$(php --ini | grep -oP '.*xdebug\.ini(?=,|$)')
if [ ! -f "$xdebugIniPath" ]; then
	echo "[Provision] Error: PHP xdebug.ini file not found at $xdebugIniPath"
	exit 1
fi
echo "xdebug.mode=coverage,debug" | sudo tee -a "$xdebugIniPath" > /dev/null
echo "xdebug.start_with_request=yes" | sudo tee -a "$xdebugIniPath" > /dev/null
echo "xdebug.client_host=192.168.33.1" | sudo tee -a "$xdebugIniPath" > /dev/null
sudo systemctl restart apache2

echo "[Provision] Creating a symlink for the source directory..."
sudo ln -s /vagrant/source /var/www/html/source

echo "[Provision] Setting initial directory..."
echo 'cd /vagrant' >> /home/vagrant/.bashrc

echo "[Provision] Cleaning up disk space..."
sudo apt-get clean
sudo apt-get autoclean
sudo apt-get autoremove --purge
cat /dev/null > ~/.bash_history

echo "[Provision] Completed successfully."
