#!/bin/bash

echo "🔍 Scanning installed PHP versions..."

# Cari versi PHP yang punya modul Apache
mapfile -t PHP_VERSIONS < <(ls /usr/lib/apache2/modules | grep -oP 'libphp\K[0-9.]+(?=\.so)' | sort -u)

if [ ${#PHP_VERSIONS[@]} -eq 0 ]; then
    echo "❌ No PHP Apache modules found! Install via: sudo apt install libapache2-mod-phpX.Y"
    exit 1
fi

echo "🔀 PHP Version Switcher (Apache + CLI)"
echo "--------------------------------------"
for i in "${!PHP_VERSIONS[@]}"; do
    echo "$((i+1)). PHP ${PHP_VERSIONS[$i]}"
done

echo ""
read -p "👉 Pilih versi PHP yang mau diaktifkan [1-${#PHP_VERSIONS[@]}]: " choice

index=$((choice - 1))

if [[ $index -lt 0 || $index -ge ${#PHP_VERSIONS[@]} ]]; then
    echo "❌ Pilihan tidak valid!"
    exit 1
fi

SELECTED_VERSION="${PHP_VERSIONS[$index]}"

echo ""
echo "⏳ Mengaktifkan PHP ${SELECTED_VERSION}..."

# ========== Apache ==========
echo "🧼 Menonaktifkan semua modul PHP Apache..."
for ver in "${PHP_VERSIONS[@]}"; do
    sudo a2dismod php${ver} > /dev/null 2>&1
done

echo "✅ Mengaktifkan php${SELECTED_VERSION} di Apache..."
sudo a2enmod php${SELECTED_VERSION}
sudo systemctl restart apache2

# ========== CLI ==========
PHP_BIN="/usr/bin/php${SELECTED_VERSION}"
if [ ! -f "$PHP_BIN" ]; then
    echo "⚠️  Versi PHP $SELECTED_VERSION tidak ditemukan untuk CLI!"
else
    echo "⚙️  Menyetel CLI default ke PHP ${SELECTED_VERSION}..."
    sudo update-alternatives --install /usr/bin/php php $PHP_BIN 100
    sudo update-alternatives --set php $PHP_BIN
fi

echo ""
php -v
echo "🎉 PHP ${SELECTED_VERSION} sekarang aktif (Apache + CLI)"
