#!/bin/bash
set -e

# Idempotency check: Exit if already installed
if [ -d "$HOME/antigravity_root" ]; then
    echo "Antigravity suite already installed. Skipping."
    exit 0
fi

echo "Installing Antigravity Suite..."

# 1. Download and Install
mkdir -p "$HOME/antigravity_root"
wget -q https://antigravity.org/download/v2.0/core.tar.gz -O /tmp/core.tar.gz
tar -xzvf /tmp/core.tar.gz -C "$HOME/antigravity_root"

# 2. Add to PATH only if not already present
if ! grep -q "antigravity_root" "$HOME/.bashrc"; then
    echo 'export PATH="$HOME/antigravity_root/bin:$PATH"' >> "$HOME/.bashrc"
fi

# 3. Setup CLI
cd "$HOME/antigravity_root" && ./setup_cli.sh --local

echo "Antigravity setup complete."
