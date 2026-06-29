#!/data/data/com.termux/files/usr/bin/bash

# ============================================================
#  Termux First-Time Init
#  Jalankan sekali saat pertama buka Termux
#  https://github.com/linecodevop-sys/Fedora-termux
# ============================================================

set -e

GREEN='\033[0;32m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
WHITE='\033[1;37m'
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

step() {
  echo ""
  echo -e "  ${BOLD}${BLUE}▶ $1${RESET}"
  echo -e "  ${GRAY}$(printf '─%.0s' {1..45})${RESET}"
}

done_msg() {
  echo -e "  ${GREEN}✔${RESET}  $1"
}

echo ""
echo -e "  ${CYAN}Fedora-Termux · First Time Setup${RESET}"
echo -e "  ${GRAY}$(printf '─%.0s' {1..45})${RESET}"
echo ""

# ── [1/3] Update & Upgrade ───────────────────────────────────
step "[1/3] Update & upgrade Termux packages"
pkg update -y && pkg upgrade -y
done_msg "Termux up to date"

# ── [2/3] Install proot-distro ───────────────────────────────
step "[2/3] Install proot-distro"
pkg install proot-distro -y
done_msg "proot-distro installed"

# ── [3/3] Install & setup Fedora ─────────────────────────────
step "[3/3] Install Fedora (proot-distro)"

if proot-distro list | grep -q "^fedora"; then
  echo -e "  ${GRAY}ℹ  Fedora sudah terinstall, skip.${RESET}"
else
  echo -e "  ${GRAY}→  Downloading Fedora...${RESET}"
  proot-distro install fedora
  done_msg "Fedora installed"
fi

# ── Alias fedora ke ~/.bashrc Termux ─────────────────────────
if ! grep -q "alias fedora=" ~/.bashrc 2>/dev/null; then
  echo "" >> ~/.bashrc
  echo "# Fedora proot-distro" >> ~/.bashrc
  echo "alias fedora='proot-distro login fedora'" >> ~/.bashrc
  done_msg "Alias 'fedora' ditambahkan ke ~/.bashrc"
else
  echo -e "  ${GRAY}ℹ  Alias 'fedora' sudah ada.${RESET}"
fi

source ~/.bashrc 2>/dev/null || true

echo ""
echo -e "  ${GRAY}$(printf '─%.0s' {1..45})${RESET}"
echo -e "  ${GREEN}${BOLD}✅  Termux siap!${RESET}"
echo ""
echo -e "  Sekarang jalankan:"
echo -e "  ${WHITE}  fedora${RESET}          → masuk ke Fedora"
echo -e "  ${WHITE}  bash setup.sh${RESET}   → jalankan setup di dalam Fedora"
echo ""
