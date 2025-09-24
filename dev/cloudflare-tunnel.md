# 🚀 Cloudflare Tunnel Setup Guide  

## 🧠 Dasar Teori: Apa itu Cloudflare Tunnel?
Secara umum, tunneling adalah teknik komunikasi di jaringan komputer di mana sebuah protokol dikirimkan di dalam protokol lain.
👉 Jadi, seakan-akan kita bikin jalur rahasia di atas jalur yang sudah ada.

Bayangin biasanya kalau kamu mau akses server di rumah (misalnya Proxmox/NAS) dari luar, kamu butuh:  
- **Public IP** (yang kadang mahal / dinamis dari ISP)  
- **Port forwarding** di router (ribet & riskan)  

Nah, **Cloudflare Tunnel** bekerja kebalikannya:  
- Server kamu yang “**menjemput bola**” → bikin koneksi outbound ke jaringan Cloudflare.  
- Jadi servermu **tidak perlu public IP** → cukup internet biasa.  
- Cloudflare jadi perantara (reverse proxy) antara user & server kamu.  

⚡ **Analogi sederhana:**  
- Anggap server kamu itu rumah.  
- Biasanya tamu (client) harus tahu alamat rumah (public IP) buat datang.  
- Dengan tunnel, kamu pasang “grab driver” (cloudflared) yang jemput tamu dari Cloudflare.  
- Jadi tamu cukup ke **kantor Cloudflare (domain kamu)**, nanti Cloudflare yang panggil driver buat nganterin tamu ke rumah.  

---

## 🎯 Kenapa Cloudflare Tunnel?

* 🌍 Ekspos layanan lokal ke internet dengan **1 klik**  
* 🔐 HTTPS langsung jadi (gak perlu beli sertifikat)  
* ⚡ Gak butuh **public IP / port forwarding**  
* 🛡️ Perlindungan DDoS bawaan Cloudflare  

> Intinya: simple, secure, GRATIS.  

---

## 📦 Prasyarat

Sebelum berangkat, siapin dulu:

- Domain yang dikelola di [Cloudflare Dashboard](https://dash.cloudflare.com)  
- Server/PC/Linux machine (Ubuntu/Debian contoh di sini)  
- Internet aktif 🚀  

---

## 🛠️ Langkah-Langkah Setup

### 1️⃣ Install `cloudflared`

```bash
# download .deb (Ubuntu/Debian x86_64)
curl -L -o cloudflared.deb \
  https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb

# install
sudo dpkg -i cloudflared.deb
sudo apt-get install -f   # jika ada dependency error

# cek versi
cloudflared --version
````

👉 Kalau pakai Raspberry Pi/ARM → ganti link dengan versi `arm64`/`armhf`.

---

### 2️⃣ Login ke Cloudflare

```bash
cloudflared tunnel login
```

Browser akan terbuka → pilih domain yang kamu pakai.
Sekarang server kamu udah “kenal” dengan akun Cloudflare 🎉

---

### 3️⃣ Buat Tunnel Baru

Misalnya kasih nama `serverku`:

```bash
cloudflared tunnel create serverku
```

📁 Perintah ini bikin file credential `UUID.json` → itu semacam **kunci rahasia** tunnel kamu (jangan dishare!).

---

### 4️⃣ Hubungkan ke Subdomain

```bash
cloudflared tunnel route dns serverku app.dwiwijaya.com
```

☁️ Cloudflare otomatis bikin DNS record → `app.dwiwijaya.com` → pointing ke tunnel.

---

### 5️⃣ Atur Config Tunnel

Edit `~/.cloudflared/config.yml`:

```yaml
tunnel: serverku
credentials-file: /home/username/.cloudflared/serverku.json

ingress:
  - hostname: app.dwiwijaya.com
    service: http://localhost:8080
  - service: http_status:404
```

💡 Ganti `localhost:8080` dengan port aplikasi kamu (contoh Proxmox `https://localhost:8006`).

---

### 6️⃣ Jalankan Tunnel Manual

```bash
cloudflared tunnel run serverku
```

Sekarang coba akses:
👉 [https://app.dwiwijaya.com](https://app.dwiwijaya.com) 🚀

---

## 🔄 Auto-Start Tunnel Saat Boot

Biar gak repot start manual, kita bikin systemd service:

1. Pindahin config & credential ke lokasi standar:

   ```bash
   sudo mkdir -p /etc/cloudflared
   sudo cp ~/.cloudflared/config.yml /etc/cloudflared/
   sudo cp ~/.cloudflared/*.json /etc/cloudflared/
   ```

   Lalu edit `config.yml` → pastikan path JSON pakai `/etc/cloudflared/`.

2. Buat service:

   ```bash
   sudo nano /etc/systemd/system/cloudflared.service
   ```

   Isi dengan:

   ```ini
   [Unit]
   Description=Cloudflare Tunnel
   After=network-online.target
   Wants=network-online.target

   [Service]
   TimeoutStartSec=0
   Type=notify
   ExecStart=/usr/bin/cloudflared --no-autoupdate --config /etc/cloudflared/config.yml tunnel run
   Restart=on-failure
   RestartSec=5s

   [Install]
   WantedBy=multi-user.target
   ```

3. Aktifkan service:

   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable cloudflared
   sudo systemctl start cloudflared
   ```

4. Cek status:

   ```bash
   systemctl status cloudflared
   ```

📌 Sekarang tunnel kamu otomatis nyala tiap kali server restart 🔥

---

## 🗺️ Gambaran Alur

```
Browser → https://app.dwiwijaya.com
         ↓
   Cloudflare Edge (SSL + DDoS)
         ↓
   Tunnel (cloudflared di server)
         ↓
   Layanan Lokal (http://localhost:8080)
```

---

## 💡 Referensi

* 📘 [Cloudflare Tunnel Docs](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/)
* 💾 [cloudflared Releases](https://github.com/cloudflare/cloudflared/releases)

---

✨ Selamat mencoba!
Kalau setup ini bermanfaat, jangan lupa kasih ⭐ di repo biar makin semangat berbagi 😉


