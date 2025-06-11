# 🐧 Ubuntu 24 LTS Personal Configuration

> My personal setup guide and dotfiles for Ubuntu 24 LTS on my laptop.  
> This repo is intended to make reinstalling or setting up a new machine easier and more consistent.

---

## 📌 Table of Contents

- [Overview](#overview)
- [System Info](#system-info)
- [UI / Desktop Setup](#ui--desktop-setup)
- [Development Environment](#development-environment)
- [System Tweaks](#system-tweaks)
- [Network & Internet](#network--internet)
- [Privacy & Security](#privacy--security)
- [Favorite Apps](#favorite-apps)
- [Dotfiles](#dotfiles)
- [Screenshots](#screenshots)
- [License](#license)

---

## 🧭 Overview

This repository contains:
- Notes and commands for setting up Ubuntu 24.04 LTS
- Dotfiles for terminal and development tools
- UI and theming setup
- Personal tweaks and preferences
- Scripts for automation (coming soon)

---

## 🖥️ System Info

- **OS**: Ubuntu 24.04 LTS "Noble Numbat"
- **Laptop**: [Your Laptop Model]
- **DE**: GNOME 46
- **Shell**: Zsh with Oh-My-Zsh + Starship
- **Window Theme**: [Theme Name]
- **Icons**: [Icon Pack]
- **Font**: JetBrains Mono / Fira Code

---

## 🎨 UI / Desktop Setup

- GNOME Extensions used:
  - Dash to Dock
  - Blur my Shell
  - Clipboard Indicator
- Fonts, scaling, and HiDPI settings
- Terminal with transparency + custom prompt (Starship)

➡️ [UI Setup Details](./ui/README.md)

---

## 💻 Development Environment

Languages:
- Node.js (via nvm)
- PHP + Composer
- Python + pip + venv
- Git + GitHub CLI

Tools:
- Docker & Docker Compose
- VS Code + Extensions
- PostgreSQL, Redis

➡️ [Dev Setup Details](./dev/README.md)

---

## ⚙️ System Tweaks

- Performance tuning (swap, preload, etc.)
- TLP / auto-cpufreq for battery
- Custom keyboard shortcuts
- Cron jobs and cleanup automation

➡️ [System Tweaks](./tweaks/README.md)

---

## 🌐 Network & Internet

- SSH setup with keys
- VPN configuration (WireGuard)
- DNS and proxy settings

---

## 🔐 Privacy & Security

- GNOME privacy settings
- App permissions
- UFW firewall setup

---

## 📦 Favorite Apps

- Firefox / Brave
- Spotify
- Obsidian
- Telegram / Discord
- Joplin / Notion (via web)

---

## ⚙️ Dotfiles

This repo includes configs for:
- `.zshrc`
- `.bashrc`
- `.gitconfig`
- `.vimrc`
- `starship.toml`
- `tmux.conf`

You can manage these using symlink tools like `chezmoi` or `stow`.

➡️ [Dotfiles Folder](./dotfiles/)

---

## 🖼️ Screenshots

| Desktop | Terminal | VS Code |
|--------|----------|---------|
| ![](screenshots/desktop.png) | ![](screenshots/terminal.png) | ![](screenshots/vscode.png) |

---

## 📄 License

MIT License © [Your Name]
