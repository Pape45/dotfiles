# Nix flake: macOS + my VPS (via Home Manager)

This repo has two separate targets so I don’t mix macOS-only stuff with server needs

- **macOS**: system configuration via `nix-darwin` + Home Manager
- **Ubuntu VPS**: user environment via **standalone Home Manager** (no `nix-darwin`, no Doom Emacs)

The entrypoints are:
- `darwinConfigurations.emacs`
- `homeConfigurations.vps` (recommended)
- `homeConfigurations."ubuntu@pipavnic"` (alias)

## Quick commands

### macOS (rebuild)
```sh
cd ~/dotfiles/nix-config
sudo -i darwin-rebuild switch --flake .#emacs
```

### macOS (update inputs)
```sh
cd ~/dotfiles/nix-config
nix flake update --commit-lock-file && sudo -i darwin-rebuild switch --flake .#emacs
```

### VPS (apply Home Manager)
```sh
cd ~/dotfiles/nix-config
nix run github:nix-community/home-manager/master -- switch --flake .#vps
```

### VPS (update inputs)
```sh
cd ~/dotfiles/nix-config
nix flake update --commit-lock-file
nix run github:nix-community/home-manager/master -- switch --flake .#vps
```

Note: the VPS system arch is set in `flake.nix` (`vpsSystem`).

## What to edit (so I don’t get lost)

### Shared (macOS + VPS)

- `modules/home/common.nix`
  - Zsh config (`programs.zsh.*`), aliases (`home.shellAliases`)
  - Git config (`programs.git.*`)
  - `direnv` + `nix-direnv` (recommended for per-project dev envs on the VPS)

### macOS-only 

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

### Ubuntu VPS-only 

- `modules/home/server.nix`
  - VPS packages (`home.packages`)
  - VPS tools toggles (e.g. `programs.tmux.enable = true;`)

- `hosts/pipavnc/home.nix`
  - VPS username/home (`/home/...`) and Home Manager stateVersion


## Bootstrap VPS

```sh
# Install Nix
sh <(curl -L https://nixos.org/nix/install) --daemon
sudo mkdir -p /etc/nix
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf

# Clone dotfiles
git clone https://github.com/<repo>.git ~/dotfiles

# Apply config
cd ~/dotfiles/nix-config
nix run github:nix-community/home-manager/master -- switch --flake .#vps

# Set zsh as default
chsh ubuntu -> /home/ubuntu/.nix-profile/bin/zsh
```