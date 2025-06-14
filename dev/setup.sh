#!/bin/bash

# === Exit immediately on any error ===
set -e

# === CONFIG SECTION ===                                                                                  setup-lamp-fixed-2.sh                                                                                                                 
MYSQL_ROOT_PASSWORD="MyR00t_P@ssw0rd!"
MYSQL_DEV_PASSWORD="D3vUser!123"
PHP_DEFAULT_VERSION="8.1"  # Bisa 7.4 / 8.1 / 8.2 / 8.3

# === UPDATE & BASIC INSTALL ===
echo "📦 Updating system & installing Apache + MySQL..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y apache2 curl software-properties-common gnupg2 ca-certificates lsb-release

# === INSTALL MYSQL ===
echo "🛠️ Installing MySQL..."
sudo apt install -y mysql-server

# === SECURE MYSQL ===
echo "🔐 Securing MySQL..."
sudo mysql <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${MYSQL_ROOT_PASSWORD}';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
EOF

# === CREATE MYSQL DEV USER ===
echo "👤 Creating MySQL user 'dev'..."
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF
CREATE USER IF NOT EXISTS 'dev'@'localhost' IDENTIFIED BY '${MYSQL_DEV_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'dev'@'localhost';
FLUSH PRIVILEGES;
EOF

# === ADD PHP REPO ===
echo "➕ Adding PHP repo..."
sudo add-apt-repository -y ppa:ondrej/php
sudo apt update

# === INSTALL MULTI PHP VERSIONS + MOD_APACHE ===
echo "📦 Installing PHP versions (7.4, 8.1, 8.2, 8.3)..."
sudo apt install -y \
  php7.4 php7.4-mysql libapache2-mod-php7.4 \
  php8.1 php8.1-mysql libapache2-mod-php8.1 \
  php8.2 php8.2-mysql libapache2-mod-php8.2 \
  php8.3 php8.3-mysql libapache2-mod-php8.3

# === DISABLE ALL PHP MODS (PREVENT CONFLICT) ===
echo "🧹 Disabling all Apache PHP modules..."
sudo a2dismod php7.4 php8.1 php8.2 php8.3 > /dev/null 2>&1

# === ENABLE DEFAULT PHP VERSION ===
echo "✅ Enabling PHP ${PHP_DEFAULT_VERSION} for Apache..."
sudo a2enmod php${PHP_DEFAULT_VERSION}
sudo systemctl restart apache2

# === SET CLI PHP DEFAULT ===
echo "🛠️ Setting CLI PHP to ${PHP_DEFAULT_VERSION}..."
sudo update-alternatives --install /usr/bin/php php /usr/bin/php${PHP_DEFAULT_VERSION} 100
sudo update-alternatives --set php /usr/bin/php${PHP_DEFAULT_VERSION}

# === CREATE TEST PAGE ===
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php > /dev/null

# === INSTALL PHPMYADMIN ===
echo "📦 Installing phpMyAdmin..."
sudo apt install -y phpmyadmin

echo "🔗 Enabling phpMyAdmin config in Apache..."
sudo ln -sf /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
sudo a2enconf phpmyadmin
sudo systemctl reload apache2

# === FINAL MESSAGE ===
echo ""
echo "🎉 LAMP Stack + Multi PHP + phpMyAdmin setup completed!"
echo "🌐 Test PHP:         http://localhost/info.php"
echo "🌐 Access phpMyAdmin: http://localhost/phpmyadmin"
echo "🔐 MySQL root user:  root / ${MYSQL_ROOT_PASSWORD}"
echo "👤 MySQL dev user:   dev / ${MYSQL_DEV_PASSWORD}"
