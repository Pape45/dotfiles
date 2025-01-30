# Nix Configuration for macOS

This is my personal Nix configuration for macOS.
At the time of writting, everything is working on : MacOS 15.3 (24D60)

## Project Structure

- `flake.nix`: Main entry point of the configuration. Contains dependencies and global configurations.
- `hosts/emacs/default.nix`: Host-specific configuration for "emacs". Used to define settings and packages specific to this machine.
- `modules/darwin/apps.nix`: List of applications to install on macOS.
- `modules/darwin/dock.nix`: Dock configuration. Allows customization of the Dock's appearance and behavior.
- `modules/darwin/fonts.nix`: Font configuration. Manages the installation and configuration of fonts.
- `modules/darwin/system.nix`: System configuration. Contains global system settings, such as security and performance preferences.
- `modules/home-manager/zsh.nix`: ZSH configuration with Home Manager. Customizes the ZSH shell with plugins and themes.
- `README.md`: This file. Contains information about the project's structure and usage.

## Usage

```sh
nix flake update --commit-lock-file

darwin-rebuild switch --flake ~/nix.#emacs
```

## Additional information

- I'll need to manually configure the font of the terminal cuz i'am unable to automate the default macOS terminal font neither with home manager or starships.

## Resources

- [Nix Documentation](https://nixos.org/manual/nix/stable/)
- [Home Manager Documentation](https://nix-community.github.io/home-manager/)
- [Nix Flakes](https://nixos.wiki/wiki/Flakes)
- [Get all parameters](file:///nix/store/c831ggd6ncv1ks2mf32ngan4sq5p1kyb-darwin-manual-html/share/doc/darwin/index.html)
- [Nix darwin Wiki](https://daiderd.com/nix-darwin/manual/index.html)
- [Nix flakes (unofficial) manual](https://nixos-and-flakes.thiscute.world/)