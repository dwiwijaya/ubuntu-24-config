# 📦 Node.js Dev Environment with NVM + Yarn + Bun + PM2

> **🔧 Setup Node.js Multi-Version via NVM — For Devs Who Want Full Control ⚡**

---

## 🧠 Kenapa Pake NVM?

> Lo bisa install **banyak versi Node.js**, dan **ganti kapan aja** cuma dengan 1 command 😎
> Perfect banget kalau lo kerja di berbagai project yang butuh versi beda-beda (misal: React pake 18, backend pake 16, legacy pake 14, dst).

---

## 🚀 Step-by-Step Install Guide

---

### ✅ 1. Install NVM (Node Version Manager)

> Download & install via script resmi dari GitHub:

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
```

📁 Script ini bakal:

* Clone repo NVM ke `~/.nvm`
* Tambahin config ke `.bashrc`, `.zshrc`, atau `.profile` (tergantung shell lo)

---

### 🔁 2. Aktifkan NVM di Shell (Opsional)

Kadang NVM belum langsung aktif habis install. Pastikan environment-nya ke-load:

```bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```

💡 Tambahkan ini ke `.bashrc` atau `.zshrc` lo biar ke-load otomatis next time.

---

### 🧪 3. Cek Apakah NVM Sudah Terinstall

```bash
nvm --version
```

Kalo muncul versi (contoh: `0.39.7`) berarti sukses ✅

---

### 📦 4. Install Node.js dengan Versi Bebas 🎯

```bash
nvm install --lts
nvm install 18
nvm install 20
nvm install 16
```

🔁 NVM otomatis install `npm` juga bareng Node.js-nya.

---

### 🔄 5. Ganti Versi Node Aktif

```bash
nvm use 18
```

Atau lihat semua versi yang udah diinstall:

```bash
nvm ls
```

Set default biar gak gonta-ganti tiap buka terminal:

```bash
nvm alias default 18
```

---

### 🔎 6. Cek Versi Node dan NPM

```bash
node -v
npm -v
```

---

## 🧼 Optional: Uninstall Node Version

```bash
nvm uninstall 16
```
---

## Optional: Install Yarn (Optional Tapi Populer)

📌 Yarn = Alternative package manager ke `npm`, lebih cepat & stabil di beberapa kasus.

Install via Corepack (sejak Node 16.10+):

```bash
corepack enable
corepack prepare yarn@stable --activate
```

Atau via npm:

```bash
npm install -g yarn
```

Cek versi:

```bash
yarn -v
```

---

## Optional: Install Bun (Opsional Tapi HYPE)

📌 Bun = all-in-one JS runtime, package manager, bundler, test runner.
Super cepat & langsung bisa gantiin Node di banyak use-case.

Install via script:

```bash
curl -fsSL https://bun.sh/install | bash
```

> Tambahin export ke shell config kalau perlu:

```bash
echo 'export BUN_INSTALL="$HOME/.bun"' >> ~/.bashrc
echo 'export PATH="$BUN_INSTALL/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Tes:

```bash
bun --version
```

---

## Optional: Install PM2 (Production Process Manager)

📌 PM2 bikin lo bisa run & monitor Node.js apps di background.
Cocok banget buat server-side stuff.

Install:

```bash
npm install -g pm2
```

Contoh:

```bash
pm2 start index.js
pm2 list
pm2 logs
```

Save config:

```bash
pm2 save
pm2 startup  # generate service untuk restart otomatis
```

---

## Bonus: Check Installed Versions

```bash
node -v       # versi Node aktif
npm -v        # versi npm aktif
yarn -v       # Yarn (if installed)
bun -v        # Bun (if installed)
pm2 -v        # PM2
```

---

## 🔥 Tips Dev: Project-Level Version Lock

Kalo kerja tim atau multi-proyek, biasakan bikin `.nvmrc`:

```bash
echo "20" > .nvmrc
```

Jadi pas buka project:

```bash
nvm use
```

Dan Node akan otomatis ikutin versi dari file itu. Clean & pro!

---

## ✨ Recommended Combo

| Tool | Gunanya                     | Kapan Dipakai                        |
| ---- | --------------------------- | ------------------------------------ |
| NVM  | Manage banyak Node.js versi | Kalau lo sering pindah project       |
| Yarn | Paket manager alternatif    | Kalau npm lemot / CI pipeline        |
| Bun  | Runtime baru & cepat        | Kalau lo mau eksperimen modern build |
| PM2  | Run & monitor Node apps     | Saat deploy app ke server            |

---

## 🤯 Tips Dev Pro

| 🔥 Need                 | ✅ Command                                                         |
| ----------------------- | ----------------------------------------------------------------- |
| Install latest LTS      | `nvm install --lts`                                               |
| Install latest version  | `nvm install node`                                                |
| List remote versions    | `nvm ls-remote`                                                   |
| Use version per project | Tambah `.nvmrc` di root project                                   |
| Auto switch version     | Install [AVN](https://github.com/wbyoung/avn) (optional power-up) |

---

## 🧩 Add to Project: `.nvmrc`

Biar semua dev di tim auto pake versi sama, taruh ini di root:

```
18
```

Terus di terminal:

```bash
nvm use
```

NVM bakal baca `.nvmrc` dan otomatis switch ke versi itu 🙌

---

## ✅ Selesai! Lo Sekarang Bisa:

* Install banyak versi Node.js
* Switch antar versi super gampang
* Ngembangin berbagai project tanpa versi konflik 💥

