#!/bin/bash

# ============================================================
#  Fedora Dev Setup for Termux (proot-distro)
#  https://github.com/linecodevop-sys/Fedora-termux
# ============================================================

set -e

# Colors
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
GRAY='\033[0;90m'
BOLD='\033[1m'
RESET='\033[0m'

# ── Banner (Fedora Logo ASCII Art) ───────────────────────────
print_banner() {
  clear
  echo ""
  echo -e "${BLUE}"
  echo '         .:;+X$XX$X+;:.         '
  echo '      :+X$XX$$$$$$$XX$X+:       '
  echo '    ;X$XX$$$$$$$$$$$$$XX$X;     '
  echo '  .X$$X$$$$$$$$$$$$$$$$$XX$X.   '
  echo '  X$$$X$$$$$$$$$$$$$$$$$$XX$$   '
  echo ' X$$$$X$$$$$$XX+;;+X$$$$$XX$$$  '
  echo ' $$$$$X$$$$$X;       ;X$$$$X$$$ '
  echo ' $$$$$X$$$$X.    ..   .X$$$X$$$ '
  echo ' $$$$$X$$$$:  .X$$$$X.  $$$X$$$ '
  echo ' X$$$$X$$$X  X$$$$$$$$  X$$X$$X '
  echo '  X$$$X$$$X  X$$$$$$$$  X$XX$$X '
  echo '  .$$$$X$$$X  .X$$$$X.  $$$X$X. '
  echo '    ;$$$X$$$X.   ..   .X$$$X+   '
  echo '      +$$$X$$$$X;;;X$$$$X$+     '
  echo '        :+X$$X$$$$$$$XX+:       '
  echo '            .;+XXXXX+;.         '
  echo -e "${RESET}"
  echo -e "  ${BOLD}${WHITE}Fedora Dev Environment${RESET} ${GRAY}· Termux proot-distro${RESET}"
  echo -e "  ${GRAY}https://github.com/linecodevop-sys/Fedora-termux${RESET}"
  echo ""
  echo -e "  ${CYAN}$(printf '─%.0s' {1..45})${RESET}"
  echo ""
}

# ── Spinner (minimal, no flicker spam) ───────────────────────
spinner() {
  local pid=$1
  local msg=$2
  local frames=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
  local i=0
  while kill -0 "$pid" 2>/dev/null; do
    printf "\r  ${CYAN}${frames[$i]}${RESET}  ${msg}"
    i=$(( (i+1) % 10 ))
    sleep 0.12
  done
  printf "\r  ${GREEN}✔${RESET}  ${msg}          \n"
}

# ── Step Header ──────────────────────────────────────────────
step() {
  echo ""
  echo -e "  ${BOLD}${BLUE}▶ $1${RESET}"
  echo -e "  ${GRAY}$(printf '─%.0s' {1..45})${RESET}"
}

done_msg() {
  echo -e "  ${GREEN}✔${RESET}  $1"
}

# ════════════════════════════════════════════════════════════
print_banner

# ── [1/5] Update System ──────────────────────────────────────
step "[1/5] Updating system packages"
dnf update -y &>/dev/null &
spinner $! "Updating DNF repositories"
done_msg "System up to date"

# ── [2/5] Base Tools ─────────────────────────────────────────
step "[2/5] Installing base tools"
dnf install -y \
  curl nano git gh tree zip unzip wget tar ripgrep fastfetch \
  gcc gcc-c++ make cmake &>/dev/null &
spinner $! "Installing base tools"
done_msg "Base tools installed"

# ── [3/5] Python 3.11 ────────────────────────────────────────
step "[3/5] Installing Python 3.11"
dnf install -y python3.11 python3.11-pip python3.11-devel &>/dev/null &
spinner $! "Installing Python 3.11 + pip"

# Set python3.11 sebagai default
alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1 &>/dev/null || true
alternatives --install /usr/bin/python python /usr/bin/python3.11 1 &>/dev/null || true
alternatives --set python3 /usr/bin/python3.11 &>/dev/null || true
alternatives --set python /usr/bin/python3.11 &>/dev/null || true

# Upgrade pip
python3.11 -m pip install --upgrade pip &>/dev/null || true

done_msg "Python $(python3.11 --version 2>/dev/null || echo '3.11') installed & set as default"

# ── [4/5] Node.js ────────────────────────────────────────────
step "[4/5] Installing Node.js"
dnf install -y nodejs &>/dev/null &
spinner $! "Installing Node.js"
done_msg "Node.js $(node -v 2>/dev/null || echo '') installed"

# ── [5/5] Shell Setup ────────────────────────────────────────
step "[5/5] Configuring shell & prompt"

cat > ~/.bashrc << 'BASHRC'
# Source system defaults
source /etc/bashrc 2>/dev/null || true

# ── Prompt ──────────────────────────────────────────────────
export PS1='\[\033[38;5;75m\]\u\[\033[38;5;245m\]@\[\033[38;5;114m\]\h\[\033[38;5;245m\]:\[\033[38;5;222m\]\w\[\033[0m\]\$ '

# ── Aliases ─────────────────────────────────────────────────
alias ls='ls --color=auto'
alias la='ls -la --color=auto'
alias ll='ls -l --color=auto'
alias cls='clear'
alias ..='cd ..'
alias ...='cd ../..'

# ── Colors ──────────────────────────────────────────────────
export LS_COLORS='di=38;5;75:fi=0:ln=38;5;114:ex=38;5;203:*.zip=38;5;222:*.tar=38;5;222:*.gz=38;5;222:*.js=38;5;220:*.ts=38;5;75:*.json=38;5;178:*.md=38;5;252'

# ── Python 3.11 ─────────────────────────────────────────────
export PATH="/usr/local/bin:$PATH"

# ── Node / npm ──────────────────────────────────────────────
export PATH="$HOME/.npm-global/bin:$PATH"
export NPM_CONFIG_PREFIX="$HOME/.npm-global"

# ── Editor ──────────────────────────────────────────────────
export EDITOR=nano

# ── History ─────────────────────────────────────────────────
export HISTSIZE=5000
export HISTFILESIZE=10000

# ── Fastfetch (system info tiap buka terminal) ───────────────
fastfetch
BASHRC

mkdir -p ~/.npm-global
npm config set prefix ~/.npm-global &>/dev/null || true
done_msg "Shell configured"

# ── Source & Done ────────────────────────────────────────────
source ~/.bashrc 2>/dev/null || true

echo ""
echo -e "  ${CYAN}$(printf '─%.0s' {1..45})${RESET}"
echo -e "  ${GREEN}${BOLD}✅  Setup complete!${RESET}"
echo -e "  ${CYAN}$(printf '─%.0s' {1..45})${RESET}"
echo ""
echo -e "  ${GRAY}Python:${RESET}  ${WHITE}$(python3.11 --version 2>/dev/null || echo 'python3.11')${RESET}"
echo -e "  ${GRAY}Node.js:${RESET} ${WHITE}$(node -v 2>/dev/null || echo 'node')${RESET}"
echo -e "  ${GRAY}pip:${RESET}     ${WHITE}$(python3.11 -m pip --version 2>/dev/null | cut -d' ' -f1-2 || echo 'pip')${RESET}"
echo ""
echo -e "  ${GRAY}Run ${WHITE}source ~/.bashrc${GRAY} untuk apply perubahan shell${RESET}"
echo ""
