# Nix flake: macOS (nix-darwin) + Ubuntu VPS (Home Manager)

This repo has two separate targets so I don’t mix macOS-only stuff (Homebrew, defaults, TouchID, GUI apps) with server needs (minimal, stable shell + reproducible dev envs):

- **macOS**: system configuration via `nix-darwin` + Home Manager
- **Ubuntu VPS**: user environment via **standalone Home Manager** (no `nix-darwin`, no Doom Emacs)

The entrypoints are:
- `darwinConfigurations.emacs`
- `homeConfigurations.vps` (recommended)
- `homeConfigurations."ubuntu@pipavnic"` (alias)

## Quick commands (copy/paste)

### macOS (rebuild)
```sh
cd ~/dotfiles/nix-config
sudo -i darwin-rebuild switch --flake .#emacs
```

### macOS (update inputs)
```sh
cd ~/dotfiles/nix-config
nix flake update --commit-lock-file
sudo -i darwin-rebuild switch --flake .#emacs
```

### Ubuntu VPS (apply Home Manager)
```sh
cd ~/dotfiles/nix-config
nix run github:nix-community/home-manager/master -- switch --flake .#vps
```

### Ubuntu VPS (update inputs)
```sh
cd ~/dotfiles/nix-config
nix flake update --commit-lock-file
nix run github:nix-community/home-manager/master -- switch --flake .#vps
```

Note: the VPS system arch is set in `flake.nix` (`vpsSystem`). If you ever change VPS CPU arch, update that value (e.g. `aarch64-linux` ↔ `x86_64-linux`).

## What to edit (so I don’t get lost)

### Shared (macOS + VPS)

Edit these when I want the “same shell” and shared CLI behavior on both machines:

- `modules/home/common.nix`
  - Zsh config (`programs.zsh.*`), aliases (`home.shellAliases`)
  - Git config (`programs.git.*`)
  - `direnv` + `nix-direnv` (recommended for per-project dev envs on the VPS)

### macOS-only (nix-darwin)

Edit these when the change is specifically about the Mac system:

- `modules/macos/defaults.nix`
  - Dock/Finder/trackpad/login/etc (`system.defaults.*`)

- `modules/apps/homebrew.nix` and `modules/data/homebrew-casks.nix`
  - Homebrew taps/brews/casks + MAS apps

- `modules/apps/packages.nix` and `modules/data/system-packages.nix`
  - macOS system packages (`environment.systemPackages`)

- `modules/apps/emacs.nix`
  - Emacs packages on macOS (`environment.systemPackages`), Doom dependencies, etc.

- `modules/home/darwin.nix`
  - macOS user metadata (`/Users/...`) and mac-only session paths

- `modules/home/doom.nix`
  - Doom Emacs activation + syncing (macOS only by design)

### Ubuntu VPS-only (Home Manager)

Edit these when the change should only affect the server:

- `modules/home/server.nix`
  - VPS packages (`home.packages`)
  - VPS tools toggles (e.g. `programs.tmux.enable = true;`)

- `hosts/pipavnc/home.nix`
  - VPS username/home (`/home/...`) and Home Manager stateVersion

## How to do common tasks

### Add a package on the Ubuntu VPS

1) Add it to `modules/home/server.nix` under `home.packages`.
2) Apply on the VPS:

```sh
cd ~/dotfiles/nix-config
nix run github:nix-community/home-manager/master -- switch --flake .#vps
```

### Add a package on macOS

Pick the right place:
- If it’s a normal CLI tool: add it in `modules/data/system-packages.nix` (then rebuild).
- If it’s Emacs/Doom-related: add it in `modules/apps/emacs.nix` (then rebuild).

Then:
```sh
cd ~/dotfiles/nix-config
sudo -i darwin-rebuild switch --flake .#emacs
```

### Add another VPS host later

1) Create `hosts/<new-host>/home.nix` with username + homeDirectory.
2) Add a new entry under `homeConfigurations` in `flake.nix`.
3) Apply with `--flake .#<user@host>`.

## VPS bootstrap (first install)

On the VPS (`ubuntu@pipavnic`):

1) Install Nix (daemon/multi-user is recommended on servers):
```sh
sh <(curl -L https://nixos.org/nix/install) --daemon
sudo mkdir -p /etc/nix
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf
```

2) Clone dotfiles:
```sh
git clone https://github.com/<you>/<repo>.git ~/dotfiles
```

3) Apply Home Manager:
```sh
cd ~/dotfiles/nix-config
nix run github:nix-community/home-manager/master -- switch --flake .#vps
```

4) Make Zsh the login shell (Ubuntu best practice; Home Manager will manage the config, not the system package):
```sh
sudo apt-get update && sudo apt-get install -y zsh
chsh -s /usr/bin/zsh ubuntu
```

Re-login (or `exec zsh`).

## Notes

- If the repo is dirty, add new files to git before rebuilding so flakes can see them.
- macOS Touch ID for sudo is enabled via `security.pam.services.sudo_local.touchIdAuth = true;`.
- Homebrew `onActivation` is currently non-idempotent (autoUpdate/upgrade/cleanup). Set to `false/false/"none"` if I want deterministic rebuilds.
