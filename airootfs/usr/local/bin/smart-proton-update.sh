#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# 1. DIRECTORY VALIDATION & AUTOMATIC CREATION
# ==============================================================================
STEAM_NATIVE="${HOME}/.local/share/Steam"
COMPAT_DIR="${STEAM_NATIVE}/compatibilitytools.d"

if [ ! -d "${COMPAT_DIR}" ]; then
    echo "[!] Target path missing: ${COMPAT_DIR}"
    echo "[+] Creating compatibility folder structure for Steam..."
    mkdir -p "${COMPAT_DIR}"
fi

# ==============================================================================
# 2. NETWORK CONNECTION CHECK
# ==============================================================================
if ! curl -s --head --request GET --max-time 5 https://api.github.com > /dev/null; then
    echo "[!] Offline or GitHub unreachable. Skipping update check."
    exit 0
fi

# ==============================================================================
# 3. FETCH LATEST RELEASE METADATA
# ==============================================================================
REPO="GloriousEggroll/proton-ge-custom"
API_URL="https://api.github.com/repos/${REPO}/releases/latest"

RELEASE_DATA=$(curl -s "${API_URL}")

TAG_NAME=$(echo "${RELEASE_DATA}" | python3 -c "import sys, json; print(json.load(sys.stdin).get('tag_name', ''))")
TARBALL_URL=$(echo "${RELEASE_DATA}" | python3 -c "import sys, json; data=json.load(sys.stdin); print(next((a['browser_download_url'] for a in data.get('assets', []) if a['name'].endswith('.tar.gz')), ''))")

if [ -z "${TAG_NAME}" ] || [ -z "${TARBALL_URL}" ]; then
    echo "[X] Error: Could not fetch valid release info from GitHub."
    exit 1
fi

TARGET_DIR="${COMPAT_DIR}/${TAG_NAME}"

# ==============================================================================
# 4. VERSION CHECK (Exit immediately if current)
# ==============================================================================
if [ -d "${TARGET_DIR}" ]; then
    echo "[✔] System up to date (${TAG_NAME} installed)."
    exit 0
fi

# ==============================================================================
# 5. DOWNLOAD & EXTRACT
# ==============================================================================
echo "[★] New version detected: ${TAG_NAME}"
echo "[+] Downloading..."

TEMP_DIR=$(mktemp -d)
TARBALL_PATH="${TEMP_DIR}/${TAG_NAME}.tar.gz"

curl -L --progress-bar "${TARBALL_URL}" -o "${TARBALL_PATH}"

echo "[+] Extracting into ${COMPAT_DIR}..."
tar -xzf "${TARBALL_PATH}" -C "${COMPAT_DIR}/"

rm -rf "${TEMP_DIR}"
echo "[✔] Successfully installed ${TAG_NAME}!"

# ==============================================================================
# 6. HOUSEKEEPING (Keep 2 newest versions)
# ==============================================================================
cd "${COMPAT_DIR}"
ls -dt GE-Proton* 2>/dev/null | tail -n +3 | while read -r old_ver; do
    if [ -n "${old_ver}" ]; then
        echo "[-] Pruning old release: ${old_ver}"
        rm -rf "${old_ver}"
    fi
done
