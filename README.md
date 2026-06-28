<div align="center">

```
  ███████╗███████╗██████╗  ██████╗ ██████╗  █████╗ 
  ██╔════╝██╔════╝██╔══██╗██╔═══██╗██╔══██╗██╔══██╗
  █████╗  █████╗  ██║  ██║██║   ██║██████╔╝███████║
  ██╔══╝  ██╔══╝  ██║  ██║██║   ██║██╔══██╗██╔══██║
  ██║     ███████╗██████╔╝╚██████╔╝██║  ██║██║  ██║
  ╚═╝     ╚══════╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
```

**Fedora Dev Environment Setup for Termux**  
*One script. Full stack. Zero hassle.*

[![Release](https://img.shields.io/github/v/release/linecodevop-sys/Fedora-termux?style=for-the-badge&color=51a2da&logo=fedora)](https://github.com/linecodevop-sys/Fedora-termux/releases)
[![License](https://img.shields.io/github/license/linecodevop-sys/Fedora-termux?style=for-the-badge&color=green)](LICENSE)
[![Stars](https://img.shields.io/github/stars/linecodevop-sys/Fedora-termux?style=for-the-badge&color=yellow)](https://github.com/linecodevop-sys/Fedora-termux/stargazers)
[![Issues](https://img.shields.io/github/issues/linecodevop-sys/Fedora-termux?style=for-the-badge&color=red)](https://github.com/linecodevop-sys/Fedora-termux/issues)

![Fedora](https://img.shields.io/badge/Fedora-51A2DA?style=flat-square&logo=fedora&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js_22-339933?style=flat-square&logo=node.js&logoColor=white)
![Bun](https://img.shields.io/badge/Bun-000000?style=flat-square&logo=bun&logoColor=white)
![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?style=flat-square&logo=typescript&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=flat-square&logo=android&logoColor=white)

</div>

---

## ✨ What's included

| Category | Tools |
|---|---|
| **Shell** | Bash with colored prompt, aliases, history |
| **Base Tools** | curl, nano, git, gh, tree, zip, wget, tar, ripgrep, fastfetch |
| **Compiler** | gcc, g++, make, cmake, python3 |
| **Runtime** | Node.js 22 LTS, Bun |
| **TypeScript** | typescript, tsx, ts-node |
| **Linting** | eslint, prettier |
| **Dev Tools** | nodemon, pm2, concurrently, cross-env, dotenv-cli |
| **Frameworks** | @nestjs/cli, vite, http-server |
| **Package Managers** | npm, pnpm, yarn |
| **Database** | prisma |

---

## 📋 Requirements

- Android device with [Termux](https://github.com/termux/termux-app) installed (from F-Droid, not Play Store)
- [proot-distro](https://github.com/termux/proot-distro) v5.0+
- ~2GB free storage
- Internet connection

---

## 🚀 Installation

### Step 1 — Install proot-distro in Termux

```bash
pkg update && pkg upgrade -y
pkg install proot-distro -y
```

### Step 2 — Install Fedora

```bash
proot-distro install fedora:latest --name fedora
```

### Step 3 — Add alias (optional but recommended)

```bash
echo "alias fedora='proot-distro login fedora'" >> ~/.bashrc && source ~/.bashrc
```

### Step 4 — Enter Fedora & run setup

```bash
fedora
```

Then inside Fedora, run via curl (one-liner):

```bash
curl -fsSL https://raw.githubusercontent.com/linecodevop-sys/Fedora-termux/main/setup.sh | bash
```

Or clone and run manually:

```bash
git clone https://github.com/linecodevop-sys/Fedora-termux.git
cd Fedora-termux
chmod +x setup.sh
bash setup.sh
```

### Step 5 — Apply shell changes

```bash
source ~/.bashrc
```

---

## 🎬 What happens when you run it

```
  ███████╗███████╗██████╗  ██████╗ ...
  
  ▶ [1/6] Updating system packages
  ─────────────────────────────────────────────
  ✔  System up to date

  ▶ [2/6] Installing base tools
  ─────────────────────────────────────────────
  [████████████████████░░░░░░░░░░░░░░░░░░░░] 51% Installing tools...

  ▶ [3/6] Installing Node.js 22 LTS
  ...

  ✅  Setup complete!
```

---

## 📁 File structure

```
Fedora-termux/
├── setup.sh        # Main setup script
├── README.md       # This file
└── LICENSE         # MIT License
```

---

## 🔖 Releases

| Version | Date | Notes |
|---|---|---|
| [v1.0.0](https://github.com/linecodevop-sys/Fedora-termux/releases/tag/v1.0.0) | 2026-06-28 | Initial release |

---

## 🤝 Contributing

Pull requests are welcome! If you find a bug or want to add a tool, open an issue first.

---

## 📄 License

MIT © [linecodevop-sys](https://github.com/linecodevop-sys)

---

<div align="center">
<sub>Made with ❤️ for Android developers who refuse to leave the terminal</sub>
</div>
