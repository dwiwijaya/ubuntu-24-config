#!/bin/bash

DOWNLOAD_DIR="$HOME/Downloads"

mkdir -p "$DOWNLOAD_DIR"/{Videos,Music,Documents,Archives,Images,Apps,Code,Configs,Others}

# === VIDEO ===
find "$DOWNLOAD_DIR" -maxdepth 1 \( \
    -iname "*.mp4" -or -iname "*.mkv" -or -iname "*.avi" -or \
    -iname "*.mov" -or -iname "*.flv" -or -iname "*.webm" -or \
    -iname "*.m4v" -or -iname "*.mpg" -or -iname "*.mpeg" -or \
    -iname "*.3gp" \) -exec mv -n {} "$DOWNLOAD_DIR/Videos" \;

# === AUDIO ===
find "$DOWNLOAD_DIR" -maxdepth 1 \( \
    -iname "*.mp3" -or -iname "*.wav" -or -iname "*.flac" -or \
    -iname "*.m4a" -or -iname "*.ogg" -or -iname "*.aac" -or \
    -iname "*.opus" -or -iname "*.wma" \) -exec mv -n {} "$DOWNLOAD_DIR/Music" \;

# === DOCUMENTS ===
find "$DOWNLOAD_DIR" -maxdepth 1 \( \
    -iname "*.pdf" -or -iname "*.doc" -or -iname "*.docx" -or \
    -iname "*.xls" -or -iname "*.xlsx" -or -iname "*.ppt" -or \
    -iname "*.pptx" -or -iname "*.txt" -or -iname "*.odt" -or \
    -iname "*.rtf" -or -iname "*.csv" -or -iname "*.md" -or \
    -iname "*.epub" \) -exec mv -n {} "$DOWNLOAD_DIR/Documents" \;

# === ARCHIVES ===
find "$DOWNLOAD_DIR" -maxdepth 1 \( \
    -iname "*.zip" -or -iname "*.rar" -or -iname "*.7z" -or \
    -iname "*.tar" -or -iname "*.gz" -or -iname "*.bz2" -or \
    -iname "*.xz" -or -iname "*.iso" -or -iname "*.dmg" -or \
    -iname "*.cab" -or -iname "*.arj" -or -iname "*.lzh" \) -exec mv -n {} "$DOWNLOAD_DIR/Archives" \;

# === IMAGES ===
find "$DOWNLOAD_DIR" -maxdepth 1 \( \
    -iname "*.jpg" -or -iname "*.jpeg" -or -iname "*.png" -or \
    -iname "*.gif" -or -iname "*.webp" -or -iname "*.svg" -or \
    -iname "*.heic" -or -iname "*.bmp" -or -iname "*.tiff" -or \
    -iname "*.ico" -or -iname "*.psd" \) -exec mv -n {} "$DOWNLOAD_DIR/Images" \;

# === APPS / INSTALLERS ===
find "$DOWNLOAD_DIR" -maxdepth 1 \( \
    -iname "*.deb" -or -iname "*.appimage" -or -iname "*.sh" -or \
    -iname "*.run" -or -iname "*.bin" -or -iname "*.rpm" -or \
    -iname "*.exe" -or -iname "*.msi" -or -iname "*.apk" -or \
    -iname "*.jar" \) -exec mv -n {} "$DOWNLOAD_DIR/Apps" \;

# === CODE / SOURCE FILES ===
find "$DOWNLOAD_DIR" -maxdepth 1 \( \
    -iname "*.py" -or -iname "*.js" -or -iname "*.ts" -or \
    -iname "*.html" -or -iname "*.css" -or -iname "*.scss" -or \
    -iname "*.cpp" -or -iname "*.c" -or -iname "*.java" -or \
    -iname "*.php" -or -iname "*.go" -or -iname "*.rs" -or \
    -iname "*.lua" -or -iname "*.rb" -or -iname "*.sql" \) -exec mv -n {} "$DOWNLOAD_DIR/Code" \;

# === CONFIG FILES ===
find "$DOWNLOAD_DIR" -maxdepth 1 \( \
    -iname "*.json" -or -iname "*.yaml" -or -iname "*.yml" -or \
    -iname "*.xml" -or -iname "*.toml" -or -iname "*.ini" -or \
    -iname "*.cfg" -or -iname "*.env" -or -iname "*.log" \) -exec mv -n {} "$DOWNLOAD_DIR/Configs" \;

# === OTHERS (SEMUA FILE YANG BELUM KE-PINDAH) ===
find "$DOWNLOAD_DIR" -maxdepth 1 -type f -exec mv -n {} "$DOWNLOAD_DIR/Others" \;

