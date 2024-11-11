#!/bin/bash

# Update the package list and install system dependencies
echo "Updating package list and installing dependencies..."

apt-get update -y
apt-get install -y \
    wget \
    curl \
    unzip \
    ca-certificates \
    fontconfig \
    libx11-dev \
    libxcomposite1 \
    libxrandr2 \
    libxi6 \
    libgl1-mesa-glx \
    libnss3 \
    libasound2 \
    libxss1 \
    libgdk-pixbuf2.0-0 \
    libdbus-1-3 \
    chromium \
    chromium-driver \
    python3-pip \
    python3-dev

# Install Google Chrome (stable version)
echo "Installing Google Chrome..."
curl -sS https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o /tmp/chrome.deb
dpkg -i /tmp/chrome.deb
apt-get -y --fix-broken install

# Install ChromeDriver
echo "Installing ChromeDriver..."
CHROME_DRIVER_VERSION=$(curl -sS https://chromedriver.storage.googleapis.com/LATEST_RELEASE)
wget -q "https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip" -O /tmp/chromedriver.zip
unzip /tmp/chromedriver.zip -d /usr/local/bin/
rm /tmp/chromedriver.zip

# Install Python dependencies for Selenium and WebDriver support
echo "Installing Python dependencies..."
pip3 install selenium

# Clean up
echo "Cleaning up unnecessary packages..."
rm -f /tmp/chrome.deb
apt-get clean
rm -rf /var/lib/apt/lists/*

echo "Dependencies installed successfully!"
