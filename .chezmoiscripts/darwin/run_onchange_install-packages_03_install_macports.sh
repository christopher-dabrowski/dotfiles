#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -euo pipefail

if command -v port >/dev/null 2>&1; then
  echo "MacPorts is already installed."
  exit 0
fi

# MacPorts requires Xcode Command Line Tools
if ! xcode-select -p >/dev/null 2>&1; then
  echo "Xcode Command Line Tools not found. Initiating installation..."
  xcode-select --install
  echo "Please complete the GUI installation prompt, then re-run this script."
  exit 1
fi

# Detect macOS major version
OS_VERSION=$(sw_vers -productVersion | grep -Eo '^[0-9]+' | head -n 1)

if [ "$OS_VERSION" != "26" ]; then
  echo "This script is currently configured only for macOS 26 (Tahoe). Detected version: $OS_VERSION."
  exit 1
fi

OS_NAME="Tahoe"
echo "Detected macOS $OS_NAME ($OS_VERSION)."

# Fetch the latest version tag from GitHub API
echo "Fetching the latest MacPorts version..."
LATEST_TAG=$(curl -s https://api.github.com/repos/macports/macports-base/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')

PKG_NAME="MacPorts-${LATEST_TAG}-${OS_VERSION}-${OS_NAME}.pkg"
DOWNLOAD_URL="https://github.com/macports/macports-base/releases/download/v${LATEST_TAG}/${PKG_NAME}"
TMP_DIR=$(mktemp -d)
PKG_PATH="${TMP_DIR}/${PKG_NAME}"

echo "Downloading ${PKG_NAME}..."
curl -L -o "$PKG_PATH" "$DOWNLOAD_URL"

echo "Installing MacPorts (sudo privileges required)..."
sudo installer -pkg "$PKG_PATH" -target /

echo "Cleaning up..."
rm -rf "$TMP_DIR"

echo "Installation complete."
