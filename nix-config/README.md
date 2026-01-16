# Nix flake: macOS (nix-darwin) + Ubuntu VPS (Home Manager)

Single repo that cleanly separates:
- macOS system config via `nix-darwin`
- Ubuntu VPS user env via standalone Home Manager (no `nix-darwin`, no Doom Emacs)

## Layout

- `flake.nix` – entrypoint, defines:
  - `darwinConfigurations.emacs`
  - `homeConfigurations."ubuntu@papevnic"`
- `hosts/emacs/` – host-level bits (name/home).
- `hosts/papevnic/` – VPS Home Manager host bits (username/home).
- `modules/core/` – base system (system.nix), fonts, security, nix settings (imports `modules/system/nix.nix`).
- `modules/macos/defaults.nix` – all `system.defaults` (Dock/Finder/trackpad/login/etc.).
- `modules/apps/` – packages, Homebrew, Emacs extras.
- `modules/home/` – Home Manager modules (shared, darwin-only, server-only).
- `modules/users/home.nix` – wires Home Manager into nix-darwin.
- `modules/data/` – shared lists (system packages, fonts, Dock apps, Homebrew casks).
- `modules/system/nix.nix` – nix daemon + GC/optimise settings.

## How to use

### macOS

```sh
# install nix
curl -L https://install.determinate.systems/nix | sh

# update inputs
nix flake update --commit-lock-file

# build/switch
sudo -i darwin-rebuild switch --flake ~/dotfiles/nix-config
```

If the repo is dirty, add new files (`modules/data/*`, `modules/macos/defaults.nix`, etc.) before rebuilding so the flake can see them.

### Ubuntu VPS (`ubuntu@papevnic`)

1) Install Nix (daemon/multi-user is recommended on servers):

```sh
# official installer
sh <(curl -L https://nixos.org/nix/install) --daemon

# ensure flakes are enabled for all users (daemon install)
sudo mkdir -p /etc/nix
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf
```

2) Clone your dotfiles repo on the VPS (or `rsync` it):

```sh
git clone https://github.com/<you>/<repo>.git ~/dotfiles
```

3) Apply the Home Manager config:

```sh
nix run github:nix-community/home-manager/master -- switch --flake ~/dotfiles/nix-config#ubuntu@papevnic
```

4) Zsh login shell (recommended on Ubuntu):

```sh
sudo apt-get update && sudo apt-get install -y zsh
chsh -s /usr/bin/zsh ubuntu
```

Re-login (or `exec zsh`) and you should get the same Zsh config as on macOS.

## Homebrew policy

Currently `homebrew.onActivation = { autoUpdate = true; upgrade = true; cleanup = "zap"; }`. This keeps Homebrew in sync with the declared casks but makes rebuilds less deterministic. Flip these to `false/false/"none"` if you want idempotent rebuilds and manage `brew upgrade` manually.

## Notes

- Terminal app font still needs manual tweaking (macOS Terminal doesn’t expose defaults cleanly).
- Touch ID for sudo is enabled via `security.pam.services.sudo_local.touchIdAuth = true;`.
- For VPS projects, prefer `direnv` + `use flake` per-repo (this setup enables `nix-direnv`).

## References

- [nix](https://nixos.org/manual/nix/stable/)
- [nix-darwin manual](https://daiderd.com/nix-darwin/manual/index.html)
- [Home Manager](https://nix-community.github.io/home-manager/)
- [Flakes wiki](https://nixos.wiki/wiki/Flakes)
