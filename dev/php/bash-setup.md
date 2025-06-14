# ⚡ LAMP Stack + Multi PHP Auto Installer for Ubuntu (🔥 Dev Friendly Setup)

![LAMP Banner](https://user-images.githubusercontent.com/123456789/your-custom-banner.png)

🛠️ One-line setup buat bikin full server LAMP (Apache, MySQL, PHP) di lokal Ubuntu kamu, plus:
- 📌 Multi versi PHP (switch 1 baris)
- 🛡️ MySQL root + dev user auto-setup
- 🧙 phpMyAdmin langsung ready
- ✨ Siap buat Laravel, WordPress, atau projek iseng lo sendiri

---

## 💻 Cara Pakai

### 1. Clone repo ini:

```bash
git clone https://github.com/username/lamp-auto-setup.git
cd lamp-auto-setup
````

### 2. Edit config (opsional)

```bash
nano setup-lamp.sh
```

Ubah variable di atas script:

```bash
MYSQL_ROOT_PASSWORD="MyR00t_P@ssw0rd!"
MYSQL_DEV_PASSWORD="D3vUser!123"
PHP_DEFAULT_VERSION="8.1"
```

### 3. Jalankan script:

```bash
chmod +x setup-lamp.sh
./setup-lamp.sh
```

---

## ✨ Fitur Script Ini

| Fitur            | Keterangan                               |
| ---------------- | ---------------------------------------- |
| ✅ Apache2        | Otomatis install & aktif                 |
| ✅ MySQL          | Langsung secure + root password          |
| ✅ User `dev`     | Punya akses penuh buat development       |
| ✅ PHP 7.4 ➡️ 8.3 | Bisa ganti versi dengan 1 command        |
| ✅ phpMyAdmin     | Langsung aktif di `localhost/phpmyadmin` |
| ✅ info.php       | Buat cek info server kamu                |

---

## 🔀 Ganti Versi PHP (Apache & CLI)

### Apache:

```bash
sudo a2dismod php7.4 php8.1 php8.2 php8.3
sudo a2enmod php8.3
sudo systemctl restart apache2
```

### CLI:

```bash
sudo update-alternatives --set php /usr/bin/php8.3
```

---

## 🌐 Testing

* 🧪 Test PHP: [`http://localhost/info.php`](http://localhost/info.php)
* 📊 phpMyAdmin: [`http://localhost/phpmyadmin`](http://localhost/phpmyadmin)

---

## 💡 FAQ

**Q: Apakah ini aman untuk digunakan di server production?**

> No! Ini versi **dev only**. Untuk production, perlu tambahan security dan konfigurasi Nginx, SSL, dsb.

**Q: Bisa uninstall?**

> Ya. Semua paket terinstall pakai `apt`, bisa dihapus manual atau di-reinstall ulang sistemnya.

---

## 🧠 Credits

Made with ❤️ by [Dwi](https://github.com/yourusername) — follow buat setup dev server & docker lainnya 🚀
