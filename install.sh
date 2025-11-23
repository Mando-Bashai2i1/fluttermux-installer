#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "🔧 Updating Termux..."
pkg update -y && pkg upgrade -y

echo "📦 Installing core packages..."
pkg install -y proot-distro git wget unzip tar xz-utils

echo "🐧 Installing Ubuntu..."
if proot-distro list | grep -q "ubuntu"; then
    echo "Ubuntu already installed."
else
    proot-distro install ubuntu
fi

echo "🚀 Setting up Ubuntu environment..."
proot-distro login ubuntu --shared-tmp << 'EOF'
apt update -y
apt upgrade -y

echo "📦 Installing dependencies..."
apt install -y curl git unzip xz-utils zip libglu1-mesa clang cmake ninja-build pkg-config libgtk-3-dev openjdk-17-jdk

echo "⬇️ Downloading Flutter..."
cd /root
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.0-stable.tar.xz
tar -xf flutter_linux_3.24.0-stable.tar.xz
mv flutter /opt/flutter

echo 'export PATH="/opt/flutter/bin:$PATH"' >> ~/.bashrc

echo "✔️ Flutter install complete."
EOF

echo "🎉 All done! Enter Ubuntu using:"
echo ""
echo "    proot-distro login ubuntu"
echo ""
echo "Then run:"
echo ""
echo "    source ~/.bashrc"
echo "    flutter doctor"
