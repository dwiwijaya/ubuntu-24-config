# 🔧 Fix Bluetooth Pairing Dual Boot (Ubuntu & Windows)

## 🧠 What's the Problem?

So you’ve paired your TWS earbuds, keyboard, or speaker on both Windows and Ubuntu. But after switching OS, suddenly... **boom 💥 your device won’t connect** anymore even though it's already paired before? Super annoying, right?

This is a *classic* issue for dual-boot users. Let me break it down.

---

## ❓ Why This Happens

Bluetooth pairing uses a **secret key** (called a *link key*) to identify and trust devices. But here's the catch:

* **Windows and Linux generate different link keys** when you pair the same device.
* Your Bluetooth device stores only ONE key.
* So when you pair it in Windows, then switch to Ubuntu (or vice versa), the key doesn’t match anymore, and boom — the device ghosts you.

---

## ✅ What’s the Fix?

We’ll steal (👀) the Bluetooth key from Windows and **paste it into Ubuntu** so both systems use the same key. That way, your device will be chill no matter which OS you boot into.

**TL;DR steps:**

1. Pair device in Windows ✅
2. Pair the same device in Ubuntu ✅
3. Grab Windows Bluetooth key using `chntpw`
4. Replace Ubuntu’s key with the Windows one
5. Restart & done 🎉

---

## 🛠️ Step-by-Step Tutorial (For Real Humans)

### 🔁 1. Pair Devices on Both OS

* Boot into **Windows** and pair all your Bluetooth devices.
* Then reboot and go to **Ubuntu**, pair the **same devices** there too.

Yes, even if they won’t connect — just make sure they show up as paired.

---

### 💽 2. Mount Windows Partition on Ubuntu

We need to access Windows system files from Ubuntu:

```bash
sudo mkdir /mnt/windows
sudo mount /dev/sdXY /mnt/windows
```

> Replace `/dev/sdXY` with your actual Windows partition. You can check with `lsblk` or `sudo fdisk -l`

---

### 🧪 3. Install `chntpw` Tool

```bash
sudo apt install chntpw
```

This lets us peek inside Windows registry (where the keys are hiding 👀).

---

### 🗂️ 4. Extract Link Key from Windows

```bash
cd /mnt/windows/Windows/System32/config
sudo chntpw -e SYSTEM
```

Now you’re inside the registry editor. Do this:

```bash
cd ControlSet001/Services/BTHPORT/Parameters/Keys
ls
```

This will show your Bluetooth adapter’s MAC address (like `D4F32D6E7E71`). Enter it:

```bash
cd D4F32D6E7E71
ls
```

Then you'll see subfolders named with your device MACs. Pick the one for your device:

```bash
cd A1B2C3D4E5F6   # Example device MAC
ls
```

Now get the key:

```bash
hex <value_name>   # Replace <value_name> with actual name, usually 0 or similar
```

You’ll see a long string like:

```
CE E8 1E 50 FB 83 8C 73 9B 7D 83 5B CD F4 03 35
```

Copy it (you’ll paste this later).

---

### 📁 5. Edit Ubuntu's Bluetooth Config

In a new terminal:

```bash
sudo su -
cd /var/lib/bluetooth
ls
```

You’ll see your Bluetooth adapter folder (like `D4:F3:2D:6E:7E:71`). Enter it:

```bash
cd D4:F3:2D:6E:7E:71
ls
```

Find the folder for your device:

```bash
cd A1:B2:C3:D4:E5:F6
```

Edit the `info` file:

```bash
nano info
```

Find the `[LinkKey]` section and replace the `Key=` value with the one you copied earlier — BUT remove all the spaces! Like this:

```
[LinkKey]
Key=CEE81E50FB838C739B7D835BCDF40335
Type=4
PINLength=0
```

**Save** and exit (`Ctrl+O`, `Enter`, `Ctrl+X`).

---

### 🔁 6. Repeat for All Devices

Yep. Gotta do this whole dance for each Bluetooth device. But it’s a one-time thing 🙏

---

### 🔄 7. Restart Linux

```bash
sudo reboot
```

When you log back in — boom. Your Bluetooth device should connect automatically like nothing ever happened 💅

---

## ⚠️ Important Gotchas

* **Don’t unpair** the device on either OS after syncing keys. That breaks the sync.
* If you repair on one side, you gotta do this process again 🫠
* Be super careful with copy-pasting the key — a single wrong digit ruins everything

---

## 🧠 Extra Nerdy Info (Optional)

* The key format is **hexadecimal**, 16 bytes (32 hex characters) = the secret handshake between device & OS.
* Windows stores it in registry hive: `SYSTEM` → `BTHPORT` → `Keys`
* Linux stores it in: `/var/lib/bluetooth/<adapter>/<device>/info`

---

## 🎉 You're Done!

Enjoy smooth dual-boot Bluetooth life — no more annoying re-pairing every time you switch OS.

Let me know if you want a helper script for extracting the keys or doing the config edits auto-magically ⚡
