#!/bin/sh
set -e

# OpenFang Installation Script
# This script detects the OS and architecture, downloads the latest release from GitHub,
# and installs the 'openfang' binary to /usr/local/bin.

REPO="joudrodiak/openfang-joud"
BRANCH="feat/grok"
BINARY_NAME="openfang"

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

# Map architecture names
case "$ARCH" in
    x86_64)  TARGET_ARCH="x86_64" ;;
    aarch64|arm64) TARGET_ARCH="aarch64" ;;
    *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

# Map OS names
case "$OS" in
    linux)   TARGET_OS="unknown-linux-gnu" ;;
    darwin)  TARGET_OS="apple-darwin" ;;
    *) echo "Unsupported OS: $OS"; exit 1 ;;
esac

TARGET="${TARGET_ARCH}-${TARGET_OS}"
FILENAME="openfang-${TARGET}.tar.gz"

echo "Detected Platform: $TARGET"

# Download URL (from the feat/grok branch directly)
DOWNLOAD_URL="https://github.com/$REPO/raw/$BRANCH/$FILENAME"

echo "Downloading $DOWNLOAD_URL..."
curl -L -o "$FILENAME" "$DOWNLOAD_URL"

# Extract
echo "Extracting..."
tar -xzf "$FILENAME"

# Install
echo "Installing to /usr/local/bin..."
if [ -w /usr/local/bin ]; then
    mv "$BINARY_NAME" /usr/local/bin/
else
    echo "Requesting sudo permissions to install to /usr/local/bin..."
    sudo mv "$BINARY_NAME" /usr/local/bin/
fi

# Cleanup
rm "$FILENAME"

echo "Successfully installed OpenFang! Run it with: $BINARY_NAME"
