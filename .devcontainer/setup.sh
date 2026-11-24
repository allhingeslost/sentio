#!/bin/bash
set -e

if [ -w /sys ] && command -v sudo >/dev/null 2>&1 && sudo -n true 2>/dev/null; then
    sudo mount --make-rshared / 2>/dev/null || true
fi

mkdir -p \
  ~/.config/gh \
  ~/.config/opencode \
  ~/.local/share/opencode \
  ~/.config/crush \
  ~/.local/share/crush

if [ -f /tmp/setup/.gitconfig ]; then
    cp /tmp/setup/.gitconfig ~/.gitconfig
fi

if [ -d /tmp/setup/gh ]; then
    cp -rf /tmp/setup/gh/* ~/.config/gh/ 2>/dev/null || true
fi

for file in opencode.json cli.json service.json; do
    if [ -f "/tmp/setup/opencode-config/$file" ]; then
        cp "/tmp/setup/opencode-config/$file" ~/.config/opencode/
    fi
done

if [ -f /tmp/setup/opencode-share/opencode.db ]; then
    cp /tmp/setup/opencode-share/opencode.db ~/.local/share/opencode/opencode.db
fi

if [ -d /tmp/setup/crush-config ]; then
    cp -rf /tmp/setup/crush-config/* ~/.config/crush/ 2>/dev/null || true
fi

if [ -d /tmp/setup/crush-share ]; then
    cp -rf /tmp/setup/crush-share/* ~/.local/share/crush/ 2>/dev/null || true
fi

echo "Anvil Setup Complete!"