<div align="center">

```
         .:;+X$XX$X+;:.         
      :+X$XX$$$$$$$XX$X+:       
    ;X$XX$$$$$$$$$$$$$XX$X;     
  .X$$X$$$$$$$$$$$$$$$$$XX$X.   
  X$$$X$$$$$$$$$$$$$$$$$$XX$$   
 X$$$$X$$$$$$XX+;;+X$$$$$XX$$$  
 $$$$$X$$$$$X;       ;X$$$$X$$$ 
 $$$$$X$$$$X.    ..   .X$$$X$$$ 
 $$$$$X$$$$:  .X$$$$X.  $$$X$$$ 
 X$$$$X$$$X  X$$$$$$$$  X$$X$$X 
  X$$$X$$$X  X$$$$$$$$  X$XX$$X 
  .$$$$X$$$X  .X$$$$X.  $$$X$X. 
    ;$$$X$$$X.   ..   .X$$$X+   
      +$$$X$$$$X;;;X$$$$X$+     
        :+X$$X$$$$$$$XX+:       
            .;+XXXXX+;.         
```

**Fedora Dev Environment Setup for Termux**  
*One script. Full stack. Zero hassle.*

[![Release](https://img.shields.io/github/v/release/linecodevop-sys/Fedora-termux?style=for-the-badge&color=51a2da&logo=fedora)](https://github.com/linecodevop-sys/Fedora-termux/releases)
[![License](https://img.shields.io/github/license/linecodevop-sys/Fedora-termux?style=for-the-badge&color=green)](LICENSE)
[![Stars](https://img.shields.io/github/stars/linecodevop-sys/Fedora-termux?style=for-the-badge&color=yellow)](https://github.com/linecodevop-sys/Fedora-termux/stargazers)
[![Issues](https://img.shields.io/github/issues/linecodevop-sys/Fedora-termux?style=for-the-badge&color=red)](https://github.com/linecodevop-sys/Fedora-termux/issues)

![Fedora](https://img.shields.io/badge/Fedora-51A2DA?style=flat-square&logo=fedora&logoColor=white)
![Python](https://img.shields.io/badge/Python_3.11-3776AB?style=flat-square&logo=python&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-339933?style=flat-square&logo=node.js&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=flat-square&logo=android&logoColor=white)

</div>

---

## ✨ What's included

| Category | Tools |
|---|---|
| **Shell** | Bash with colored prompt, aliases, history, fastfetch on startup |
| **Base Tools** | curl, nano, git, gh, tree, zip, wget, tar, ripgrep, fastfetch |
| **Compiler** | gcc, g++, make, cmake |
| **Python** | Python 3.11 (default), pip (full), python3.11-devel |
| **Runtime** | Node.js (latest via dnf) |

---

## 📋 Requirements

- Android device with [Termux](https://github.com/termux/termux-app) installed (dari F-Droid, bukan Play Store)
- ~2GB free storage
- Internet connection

---

## 🚀 Installation

### Langkah 1 — Setup Termux (cukup sekali)

Jalankan ini saat pertama kali buka Termux:

```bash
curl -fsSL https://raw.githubusercontent.com/linecodevop-sys/Fedora-termux/main/termux-init.sh | bash
```

Script ini otomatis:
- `pkg update && pkg upgrade`
- Install `proot-distro`
- Install Fedora (kalau belum ada)
- Tambah alias `fedora` ke `~/.bashrc`

### Langkah 2 — Masuk Fedora & jalankan setup

```bash
fedora
bash setup.sh
```

Atau langsung via curl dari dalam Fedora:

```bash
fedora
curl -fsSL https://raw.githubusercontent.com/linecodevop-sys/Fedora-termux/main/setup.sh | bash
```

### Langkah 3 — Apply shell

```bash
source ~/.bashrc
```

---

## 🎬 Tampilan saat dijalankan

```
         .:;+X$XX$X+;:.         
      :+X$XX$$$$$$$XX$X+:       
    ...  (Fedora logo)  ...      

  Fedora Dev Environment · Termux proot-distro

  ▶ [1/5] Updating system packages
  ─────────────────────────────────────────
  ✔  System up to date

  ▶ [2/5] Installing base tools
  ⠸  Installing base tools
  ✔  Base tools installed

  ▶ [3/5] Installing Python 3.11
  ✔  Python 3.11.x installed & set as default

  ✅  Setup complete!
```

---

## 📁 File structure

```
Fedora-termux/
├── termux-init.sh  # Jalankan sekali di Termux (update + install proot + Fedora)
├── setup.sh        # Jalankan di dalam Fedora
├── README.md       # This file
└── LICENSE         # Apache 2.0
```

---

## 🔖 Releases

| Version | Date | Notes |
|---|---|---|
| [v2.0.0](https://github.com/linecodevop-sys/Fedora-termux/releases) | 2026-06-29 | Refactor: Fedora logo banner, Python 3.11, termux-init.sh |
| [v1.0.0](https://github.com/linecodevop-sys/Fedora-termux/releases/tag/v1.0.0) | 2026-06-28 | Initial release |

---

## 🤝 Contributing

Pull requests are welcome! Kalau nemu bug atau mau tambah tool, open issue dulu.

---

## 📄 License

Apache 2.0 © [linecodevop-sys](https://github.com/linecodevop-sys)

---

<div align="center">
<sub>Made with ❤️ for Android developers who refuse to leave the terminal</sub>
</div>
