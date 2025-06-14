# 🧠 Manual LAMP Setup (Ubuntu) — Full Guide for Beginners

Ini panduan lengkap buat kamu yang **baru pertama kali setup server Linux**, pengen belajar LAMP stack (Linux + Apache + MySQL + PHP) secara manual ✨

---

## 📌 Apa Itu LAMP?

LAMP adalah singkatan dari:

- **Linux** (OS)
- **Apache** (Web Server)
- **MySQL** (Database)
- **PHP** (Bahasa Pemrograman)

Dipake buat ngejalanin aplikasi web kayak WordPress, Laravel, dan lainnya.

---

## 🧱 Step-by-Step Manual Setup

### 1. 🔄 Update & Install Apache

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install apache2
````

🔍 Cek: buka `http://localhost` → Harus muncul halaman Apache Default

---

### 2. 🛢️ Install MySQL

```bash
sudo apt install mysql-server
```

#### 🧠 (Opsional tapi penting): Secure MySQL

```bash
sudo mysql_secure_installation
```

💬 **Kenapa perlu?**

Tool ini bantu:

* Ganti password root
* Hapus user anonim
* Hapus database `test`
* Nonaktifkan akses root dari luar

👉 **Tujuannya:** biar database kamu **lebih aman** dan gak bisa diacak-acak orang sembarangan.

---

### 3. 🐘 Install PHP

```bash
sudo apt install php libapache2-mod-php php-mysql
```

📁 Taruh file `.php` kamu di `/var/www/html`

Tes:

```bash
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php
```

Buka di browser: `http://localhost/info.php`


Ubuntu default-nya cuma support 1 versi PHP. Tapi kamu bisa install **beberapa versi PHP (7.4, 8.1, 8.2, 8.3)** lewat PPA (repo tambahan dari Ondřej Surý).

---

### 1️⃣ Tambah PPA Repo PHP:

```bash
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update
```

---

### 2️⃣ Install Semua Versi PHP:

```bash
sudo apt install -y \
  php7.4 php7.4-mysql libapache2-mod-php7.4 \
  php8.1 php8.1-mysql libapache2-mod-php8.1 \
  php8.2 php8.2-mysql libapache2-mod-php8.2 \
  php8.3 php8.3-mysql libapache2-mod-php8.3
```

🧠 **Penjelasan:**

* `libapache2-mod-phpX.X` → Modul Apache biar bisa jalankan PHP versi X.X
* Bisa switch PHP untuk Apache dan CLI

---

### 3️⃣ Ganti Versi PHP di Apache

Apache cuma bisa aktifin satu versi PHP dalam satu waktu.
Switch versinya pakai perintah ini:

```bash
sudo a2dismod php7.4 php8.1 php8.2 php8.3
sudo a2enmod php8.1       # ganti ke versi yang kamu mau
sudo systemctl restart apache2
```

---

### 4️⃣ Ganti Versi PHP di CLI

Untuk ganti `php` versi di terminal/command line:

```bash
sudo update-alternatives --install /usr/bin/php php /usr/bin/php8.1 100
sudo update-alternatives --install /usr/bin/php php /usr/bin/php7.4 74
sudo update-alternatives --install /usr/bin/php php /usr/bin/php8.3 83

sudo update-alternatives --config php
```

Pilih nomornya, selesai 🔥

---

### ✅ Cek Versi Aktif

```bash
php -v
```

---

## 🧠 Kenapa Multi-PHP Penting?

> Kadang project butuh PHP 7.4, kadang butuh 8.2.
> Dengan setup ini, kamu bisa jalankan **banyak versi secara paralel** dan tinggal switch kapan aja. Gak perlu reinstall, gak ribet. 🔥

---

## 🚨 Note Penting

* Jangan lupa disable versi sebelumnya sebelum enable versi baru di Apache (biar gak bentrok modul).
* Bisa juga jalanin versi PHP tertentu langsung dari command:

  ```bash
  php8.1 artisan serve
  ```

### 4. 🔐 (Opsional) Buat User Database Baru

```bash
sudo mysql -u root -p
```

```sql
CREATE USER 'dev'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON *.* TO 'dev'@'localhost';
FLUSH PRIVILEGES;
```

📌 Ini buat misahin antara root dan user development, **biar lebih aman dan bisa manajemen hak akses.**

---

### 5. (Bonus) Install phpMyAdmin

```bash
sudo apt install phpmyadmin
```

Kalau diminta:

* Web server: pilih `apache2`
* Konfigurasi db: Yes
* Masukkan password root MySQL

Aktifkan konfigurasi:

```bash
sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
sudo a2enconf phpmyadmin
sudo systemctl reload apache2
```

Akses: `http://localhost/phpmyadmin`

---

## ✅ Finish!

🎉 Kamu sekarang punya LAMP Stack yang jalan full manual.

📍 Tips:

* Gunakan `systemctl` untuk ngecek status service
* Coba install Laravel atau WordPress untuk praktek lanjut


