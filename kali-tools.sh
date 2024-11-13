#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit
fi

echo "Updating and upgrading system..."
sudo apt update && sudo apt upgrade -y

echo "Adding Kali Linux repositories to sources.list..."
# Backup the original sources.list
cp /etc/apt/sources.list /etc/apt/sources.list.backup

# Add Kali Linux repositories
cat <<EOF >> /etc/apt/sources.list

# Kali Linux repositories
deb http://http.kali.org/kali kali-rolling main non-free contrib
EOF

echo "Adding Kali Linux GPG key..."
# Add the Kali Linux signing key
wget -q -O - https://archive.kali.org/archive-key.asc | sudo apt-key add -

echo "Updating package lists with Kali repositories..."
sudo apt update

echo "Installing all Kali Linux tools..."
# Install the "kali-linux-everything" meta-package to install all tools
sudo apt install -y kali-linux-everything

echo "Cleaning up..."
# Restore the original sources.list
mv /etc/apt/sources.list.backup /etc/apt/sources.list
sudo apt update

echo "Installation of all Kali Linux tools completed successfully."
