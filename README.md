````markdown
# ❄️ NixOS Configuration (Flakes + Home Manager)

Repositori ini berisi konfigurasi **NixOS declarative system** berbasis **Nix Flakes** dengan integrasi **Home Manager** untuk manajemen dotfiles dan environment user.

Konfigurasi ini mendukung **multi-host setup**, sehingga bisa digunakan di beberapa device (laptop, PC, VM) dengan konfigurasi yang konsisten.

---

## 🧠 Design Philosophy

- ❄️ **Fully declarative system** (no manual setup)
- 🔁 **Reproducible builds** using Nix Flakes
- 🧩 **Modular configuration** (system + home separation)
- 💻 **Multi-device support** (per-host config)
- 📦 **Single source of truth** for all dotfiles

---

## 🖥️ Supported Hosts

Contoh struktur host yang didukung:

- `NixOS` (atau `laptop`) → Main daily driver
- `pc-kedua` (atau `pc`) → Desktop workstation
- `vm` → Testing environment

Setiap host memiliki konfigurasi mandiri yang terdiri dari:

- `configuration.nix`
- `hardware-configuration.nix`
- Host-specific modules

---

## 📁 Repository Structure

```bash
.
├── flake.nix
├── configuration.nix
├── home.nix
├── config-files/
│   ├── zed/
│   ├── kitty/
│   ├── nvim/
│   ├── easyeffects/
│   └── kde/
├── hosts/
│   ├── laptop/
│   │   └── hardware-configuration.nix
│   ├── pc-kedua/
│   │   └── hardware-configuration.nix
│   └── vm/
└── README.md
```
````

---

## 🚀 Installation (Fresh NixOS / New Device)

### 1. Clone Repository

```bash
cd ~
mkdir -p github && cd github
git clone [https://github.com/magityas/nixos-conf.git](https://github.com/magityas/nixos-conf.git)
cd nixos-conf

```

### 2. Generate Hardware Config (Per Device)

Jalankan perintah ini untuk mengambil spesifikasi hardware asli dari perangkat baru Anda (ganti `<hostname>` sesuai folder host target, misal `pc-kedua`):

```bash
sudo nixos-generate-config --show-hardware-config > hosts/<hostname>/hardware-configuration.nix

```

### 3. Apply Configuration (Flake Build)

Daftarkan file hardware baru tersebut ke Git agar terbaca oleh Flakes, lalu jalankan proses _build_ (Gunakan `--impure` jika dotfiles Neovim/distro Anda mengandung sub-repository Git absolut):

```bash
git add .
sudo nixos-rebuild switch --impure --flake ".#<hostname>"

```

---

## 🔄 Daily Workflow

### Update config (Main Device)

```bash
cd ~/github/nixos-conf
git add .
sudo nixos-rebuild switch --impure --flake ".#NixOS"
git commit -m "chore: update config"
git push origin main

```

### Sync config (Other Devices)

```bash
cd ~/github/nixos-conf
git pull origin main
sudo nixos-rebuild switch --impure --flake ".#<hostname>"

```

---

## ⚠️ Important Notes

- Pastikan nama `hostname` saat build sesuai dengan profil yang terdaftar di `flake.nix`.
- Jangan lupa melakukan `git add` atau commit perubahan sebelum melakukan rebuild untuk menghindari masalah _dirty state/untracked files_.
- Selalu gunakan perintah berbasis `--flake`, hindari penggunaan legacy `configuration.nix` di luar folder Git ini.

---

## 🧩 Common Issues

### ❌ “Unknown flake output”

✔️ Pastikan target hostname Anda terdaftar di `flake.nix`, contoh penulisan:

```bash
sudo nixos-rebuild switch --flake ".#NixOS"

```

### ❌ “Access to absolute path is forbidden (pure evaluation mode)”

✔️ Gunakan bendera `--impure` di akhir perintah rebuild untuk mengizinkan pembacaan symlink/sub-repo di dalam dotfiles Neovim atau Kitty Anda.
