#!/usr/bin/env bash
set -euo pipefail

# Rebuild script for diem/diem
# Runs from developers.diem.com/ in the existing source tree (no clone).
# Installs deps and builds the Docusaurus site.

# --- Node version ---
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if [ -f "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"
    nvm install 20
    nvm use 20
fi
echo "[INFO] Node: $(node --version)"

# --- Package manager: Yarn classic ---
# --ignore-engines: Docusaurus 2.0.0-beta.4 has old engine requirements
# --frozen-lockfile: reproducible install
yarn install --ignore-engines --frozen-lockfile

# --- Build ---
# NODE_OPTIONS=--openssl-legacy-provider required for Docusaurus 2.0.0-beta.4 with Node 20
NODE_OPTIONS=--openssl-legacy-provider yarn build

echo "[DONE] Build complete."
