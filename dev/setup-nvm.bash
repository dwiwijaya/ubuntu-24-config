#!/bin/bash

# === CONFIG ===
NODE_VERSION="lts/*"  # Bisa diganti ke versi spesifik kayak "18" atau "20"

# === LOGIC ===

echo "🧠 Installing prerequisites..."
sudo apt update && sudo apt install -y curl unzip ca-certificates build-essential

echo "📦 Installing NVM (Node Version Manager)..."
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
else
    echo "🔁 NVM already installed, skipping..."
fi

# Source nvm (biar langsung bisa dipakai di script ini)
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

echo "🔧 Installing Node.js LTS version..."
nvm install "$NODE_VERSION"
nvm use "$NODE_VERSION"
nvm alias default "$NODE_VERSION"

echo "📦 Installing Yarn..."
corepack enable
corepack prepare yarn@stable --activate

echo "🔥 Installing Bun..."
curl -fsSL https://bun.sh/install | bash

echo "🧠 Adding Bun to current shell..."
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

echo "🚀 Installing PM2 globally..."
npm install -g pm2

# === DONE ===
echo ""
echo "✅ Dev tools installed:"
echo "🟢 Node.js: $(node -v)"
echo "📦 npm: $(npm -v)"
echo "🧶 yarn: $(yarn -v)"
echo "🔥 bun: $(bun -v)"
echo "🔁 pm2: $(pm2 -v)"
