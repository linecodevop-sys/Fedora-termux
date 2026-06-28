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

# ── Banner ───────────────────────────────────────────────────
print_banner() {
  clear
  echo -e "${BLUE}"
  echo '  ███████╗███████╗██████╗  ██████╗ ██████╗  █████╗ '
  echo '  ██╔════╝██╔════╝██╔══██╗██╔═══██╗██╔══██╗██╔══██╗'
  echo '  █████╗  █████╗  ██║  ██║██║   ██║██████╔╝███████║'
  echo '  ██╔══╝  ██╔══╝  ██║  ██║██║   ██║██╔══██╗██╔══██║'
  echo '  ██║     ███████╗██████╔╝╚██████╔╝██║  ██║██║  ██║'
  echo '  ╚═╝     ╚══════╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝'
  echo -e "${RESET}"
  echo -e "  ${GRAY}Dev Environment Setup for Termux (proot-distro)${RESET}"
  echo -e "  ${GRAY}https://github.com/linecodevop-sys/Fedora-termux${RESET}"
  echo ""
  echo -e "  ${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
  echo ""
}

# ── Spinner ──────────────────────────────────────────────────
spinner() {
  local pid=$1
  local msg=$2
  local frames=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
  local i=0
  while kill -0 "$pid" 2>/dev/null; do
    printf "\r  ${CYAN}${frames[$i]}${RESET}  ${msg}..."
    i=$(( (i+1) % 10 ))
    sleep 0.1
  done
  printf "\r  ${GREEN}✔${RESET}  ${msg}          \n"
}

# ── Progress Bar ─────────────────────────────────────────────
progress_bar() {
  local current=$1
  local total=$2
  local label=$3
  local width=40
  local filled=$(( current * width / total ))
  local empty=$(( width - filled ))
  local bar=""
  for ((i=0; i<filled; i++)); do bar+="█"; done
  for ((i=0; i<empty; i++)); do bar+="░"; done
  printf "\r  ${CYAN}[${bar}]${RESET} ${WHITE}%d%%${RESET} ${GRAY}${label}${RESET}" $(( current * 100 / total ))
}

# ── Step Header ──────────────────────────────────────────────
step() {
  echo ""
  echo -e "  ${BOLD}${BLUE}▶ $1${RESET}"
  echo -e "  ${GRAY}$(printf '─%.0s' {1..45})${RESET}"
}

# ── Done ─────────────────────────────────────────────────────
done_msg() {
  echo -e "  ${GREEN}✔${RESET}  $1"
}

# ════════════════════════════════════════════════════════════
print_banner
sleep 1

# ── [1/6] Update System ──────────────────────────────────────
step "[1/6] Updating system packages"
dnf update -y &>/dev/null &
spinner $! "Updating DNF repositories"
done_msg "System up to date"

# ── [2/6] Base Tools ─────────────────────────────────────────
step "[2/6] Installing base tools"

TOOLS=(curl nano git gh tree zip unzip wget tar ripgrep fastfetch gcc gcc-c++ make cmake python3 python3-pip)
TOTAL=${#TOOLS[@]}

dnf install -y "${TOOLS[@]}" &>/dev/null &
BG=$!
COUNT=0
while kill -0 "$BG" 2>/dev/null; do
  COUNT=$(( (COUNT + 1) % (TOTAL + 1) ))
  progress_bar "$COUNT" "$TOTAL" "Installing tools..."
  sleep 0.4
done
progress_bar "$TOTAL" "$TOTAL" "Done"
echo ""
done_msg "Base tools installed"

# ── [3/6] Node.js 22 ─────────────────────────────────────────
step "[3/6] Installing Node.js 22 LTS"
dnf install -y nodejs22 nodejs22-devel nodejs22-npm &>/dev/null &
spinner $! "Installing Node.js 22 + npm"
done_msg "Node.js $(node -v 2>/dev/null || echo '22') installed"

# ── [4/6] Shell Setup ────────────────────────────────────────
step "[4/6] Configuring shell & prompt"

cat > ~/.bashrc << 'BASHRC'
# Source system defaults
source /etc/bashrc 2>/dev/null

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

# ── Node / npm ──────────────────────────────────────────────
export PATH="$HOME/.npm-global/bin:$HOME/.bun/bin:$PATH"
export NPM_CONFIG_PREFIX="$HOME/.npm-global"

# ── Editor ──────────────────────────────────────────────────
export EDITOR=nano

# ── History ─────────────────────────────────────────────────
export HISTSIZE=5000
export HISTFILESIZE=10000
BASHRC

mkdir -p ~/.npm-global
npm config set prefix ~/.npm-global &>/dev/null
done_msg "Shell configured"

# ── [5/6] npm Global Packages ────────────────────────────────
step "[5/6] Installing global npm packages"

NPM_PKGS=(typescript tsx ts-node eslint prettier nodemon pm2 @nestjs/cli vite pnpm yarn prisma dotenv-cli concurrently cross-env http-server)
TOTAL_NPM=${#NPM_PKGS[@]}

npm install -g "${NPM_PKGS[@]}" &>/dev/null &
BG=$!
COUNT=0
while kill -0 "$BG" 2>/dev/null; do
  COUNT=$(( (COUNT + 1) % (TOTAL_NPM + 1) ))
  progress_bar "$COUNT" "$TOTAL_NPM" "Installing npm packages..."
  sleep 0.5
done
progress_bar "$TOTAL_NPM" "$TOTAL_NPM" "Done"
echo ""
done_msg "npm packages installed"

# ── [6/6] Bun ────────────────────────────────────────────────
step "[6/6] Installing Bun runtime"
curl -fsSL https://bun.sh/install | bash &>/dev/null &
spinner $! "Downloading Bun"
done_msg "Bun installed"

# ── Source & Done ────────────────────────────────────────────
source ~/.bashrc 2>/dev/null || true

echo ""
echo -e "  ${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "  ${GREEN}${BOLD}✅  Setup complete!${RESET}"
echo -e "  ${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
echo -e "  ${GRAY}Run ${WHITE}source ~/.bashrc${GRAY} to apply shell changes${RESET}"
echo ""

fastfetch
