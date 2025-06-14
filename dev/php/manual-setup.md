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

---

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


