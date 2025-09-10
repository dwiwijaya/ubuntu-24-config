# 🚀 Panduan Setup Oracle Instant Client + OCI8/PDO\_OCI di PHP 8.3 (Ubuntu 24.04)

## 🎯 Tujuan

Panduan ini membantu kamu mengintegrasikan **Oracle Database** ke **PHP 8.3** menggunakan **Oracle Instant Client** dan ekstensi **OCI8/PDO\_OCI**.
Cocok untuk developer yang butuh koneksi PHP ↔ Oracle di server Ubuntu modern.
👉 Trik penting: kita simpan **Instant Client** di folder global `/opt/oracle/` agar bisa diakses oleh PHP CLI **dan** Apache.

---

## 📦 1. Persiapan Awal

Update paket & install dependency penting:

```bash
sudo apt update
sudo apt install unzip wget php-pear php8.3-dev build-essential -y
```

---

## 📥 2. Download & Extract Oracle Instant Client

Kita akan pakai versi **21.9** (basic + sdk). Simpan di `/opt/oracle`.

```bash
sudo mkdir -p /opt/oracle && cd /opt/oracle

sudo wget https://download.oracle.com/otn_software/linux/instantclient/219000/instantclient-basic-linux.x64-21.9.0.0.0dbru.zip
sudo wget https://download.oracle.com/otn_software/linux/instantclient/219000/instantclient-sdk-linux.x64-21.9.0.0.0dbru.zip

sudo unzip instantclient-basic-linux.x64-21.9.0.0.0dbru.zip
sudo unzip instantclient-sdk-linux.x64-21.9.0.0.0dbru.zip
```

Rename biar lebih rapih:

```bash
sudo mv instantclient_21_9 instantclient_21
```

---

## ⚙️ 3. Konfigurasi Library Path

Daftarkan path Instant Client ke sistem:

```bash
echo "/opt/oracle/instantclient_21" | sudo tee /etc/ld.so.conf.d/oracle-instantclient.conf
sudo ldconfig
```

---

## 🛠️ 4. Install Ekstensi OCI8 & PDO\_OCI

Gunakan **pecl**:

```bash
sudo pecl install oci8
# Saat ditanya, isi path: instantclient,/opt/oracle/instantclient_21

sudo pecl install pdo_oci
# Masukkan path yang sama
```

---

## 📝 5. Aktifkan Ekstensi di PHP

Tambahkan konfigurasi `.ini`:

```bash
echo "extension=oci8.so" | sudo tee /etc/php/8.3/mods-available/oci8.ini
echo "extension=pdo_oci.so" | sudo tee /etc/php/8.3/mods-available/pdo_oci.ini

sudo phpenmod oci8 pdo_oci
```

Restart Apache:

```bash
sudo systemctl restart apache2
```

---

## 🩹 6. Fix Error `libaio.so.1` (Ubuntu 24.04)

Di Ubuntu 24.04, Oracle masih mencari `libaio.so.1`, padahal library aslinya `libaio.so.1t64`.
Solusi: buat symlink manual.

```bash
sudo ln -s /lib/x86_64-linux-gnu/libaio.so.1t64 /lib/x86_64-linux-gnu/libaio.so.1
sudo ldconfig
sudo systemctl restart apache2
```

---

## ✅ 7. Verifikasi

Cek apakah modul sudah aktif:

```bash
php -m | grep -E "oci8|pdo_oci"
```

Jika berhasil, akan muncul:

```
oci8
pdo_oci
```

---

## 🎉 8. Uji Coba Koneksi

Buat file `/var/www/html/conn.php`:

```php
<?php
$conn = oci_connect("user", "password", "hostname/servicename");
if ($conn) {
    echo "✅ Koneksi berhasil!";
} else {
    $e = oci_error();
    echo "❌ Koneksi gagal: " . $e['message'];
}
?>
```

Uji dari browser:
👉 `http://localhost/conn.php`
Kalau muncul "✅ Koneksi berhasil!", berarti setup kamu sukses 🚀

---

## 🔗 Referensi

* [Oracle Instant Client Downloads](https://www.oracle.com/database/technologies/instant-client.html)
* [PECL OCI8](https://pecl.php.net/package/oci8)
* [PECL PDO\_OCI](https://pecl.php.net/package/PDO_OCI)


