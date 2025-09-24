# 🚀 Cloudflare Tunnel Setup Guide

Ingin server lokal kamu (Proxmox, NAS, web app, atau dashboard apapun) bisa diakses dari mana saja tanpa ribet **public IP** atau **port forwarding**?
Yuk kenalan dengan **Cloudflare Tunnel**! 😍

Dengan Cloudflare Tunnel, kamu bisa:

* 🌍 Ekspos layanan lokal ke internet dengan aman
* 🔐 Gratis SSL (HTTPS) dari Cloudflare
* ⚡ Gak perlu public IP / utak-atik router
* 🛡️ Bonus perlindungan DDoS dari Cloudflare

---

## 📦 Prasyarat

Sebelum mulai, pastikan:

* Kamu punya **domain** yang sudah di-manage di [Cloudflare](https://dash.cloudflare.com)
* Server/PC/Linux machine yang bisa install `cloudflared`
* Internet aktif (outbound connection harus bisa)

---

## 🛠️ Langkah-Langkah Setup

### 1. Install `cloudflared`

```bash
# download .deb (Ubuntu/Debian x86_64)
curl -L -o cloudflared.deb \
  https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb

# install
sudo dpkg -i cloudflared.deb
sudo apt-get install -f   # jika ada dependency error

# cek versi
cloudflared --version
```

> 🔎 Catatan: kalau pakai ARM (Raspberry Pi, dsb), ganti link dengan file arm64/armhf.

---

### 2. Login ke Cloudflare

Hubungkan `cloudflared` dengan akun Cloudflare kamu:

```bash
cloudflared tunnel login
```

👉 Perintah ini akan membuka browser → pilih domain yang ingin kamu gunakan.

---

### 3. Buat Tunnel

Beri nama tunnel sesuai layananmu, misalnya `serverku`:

```bash
cloudflared tunnel create serverku
```

---

### 4. Bind ke Subdomain

Hubungkan tunnel ke subdomain kamu, misalnya `app.dwiwijaya.com`:

```bash
cloudflared tunnel route dns serverku app.dwiwijaya.com
```

Cloudflare otomatis menambahkan record DNS untuk subdomain ini.

---

### 5. Konfigurasi Tunnel

Edit file konfigurasi `~/.cloudflared/config.yml`:

```yaml
tunnel: serverku
credentials-file: /home/username/.cloudflared/serverku.json

ingress:
  - hostname: app.dwiwijaya.com
    service: http://localhost:8080
  - service: http_status:404
```

> Ganti `localhost:8080` dengan port/service yang mau kamu expose (contoh: Proxmox pakai `https://localhost:8006`).

---

### 6. Jalankan Tunnel

```bash
cloudflared tunnel run serverku
```

Sekarang buka browser → akses `https://app.dwiwijaya.com` 🎉


---

## 💡 Referensi

* [Cloudflare Tunnel Docs](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/)
* [cloudflared GitHub Releases](https://github.com/cloudflare/cloudflared/releases)

---

✨ Selamat mencoba!
Kalau setup ini bermanfaat, jangan lupa kasih ⭐ di repo ya 😉


