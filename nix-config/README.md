# Nix + nix-darwin setup (macOS 15.3)

Personal Darwin flake with Home Manager and Homebrew integration.

## Layout

- `flake.nix` – entrypoint, defines the `emacs` host.
- `hosts/emacs/` – host-level bits (name/home).
- `modules/core/` – base system (system.nix), fonts, security, nix settings (imports `modules/system/nix.nix`).
- `modules/macos/defaults.nix` – all `system.defaults` (Dock/Finder/trackpad/login/etc.).
- `modules/apps/` – packages, Homebrew, Emacs extras.
- `modules/users/home.nix` – Home Manager for the primary user.
- `modules/data/` – shared lists (system packages, fonts, Dock apps, Homebrew casks).
- `modules/system/nix.nix` – nix daemon + GC/optimise settings.

## How to use

```sh
# install nix
curl -L https://install.determinate.systems/nix | sh

# update inputs
nix flake update --commit-lock-file

# build/switch
sudo -i darwin-rebuild switch --flake ~/dotfiles/nix-config
```

If the repo is dirty, add new files (`modules/data/*`, `modules/macos/defaults.nix`, etc.) before rebuilding so the flake can see them.

## Homebrew policy

Currently `homebrew.onActivation = { autoUpdate = true; upgrade = true; cleanup = "zap"; }`. This keeps Homebrew in sync with the declared casks but makes rebuilds less deterministic. Flip these to `false/false/"none"` if you want idempotent rebuilds and manage `brew upgrade` manually.

## Notes

- Terminal app font still needs manual tweaking (macOS Terminal doesn’t expose defaults cleanly).
- Touch ID for sudo is enabled via `security.pam.services.sudo_local.touchIdAuth = true;`.

## References

- [nix](https://nixos.org/manual/nix/stable/)
- [nix-darwin manual](https://daiderd.com/nix-darwin/manual/index.html)
- [Home Manager](https://nix-community.github.io/home-manager/)
- [Flakes wiki](https://nixos.wiki/wiki/Flakes)
