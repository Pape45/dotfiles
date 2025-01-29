# Configuration Nix pour macOS

Ce projet contient une configuration Nix complète pour macOS, permettant de gérer les applications, les polices, le Dock, et plus encore. Il utilise Nix Flakes et Home Manager pour une gestion cohérente et reproductible de l'environnement.

## Structure du projet

- `flake.nix`: Point d'entrée principal de la configuration. Contient les dépendances et les configurations globales.
- `hosts/emacs/default.nix`: Configuration spécifique à l'hôte "emacs". Utilisé pour définir les paramètres et les paquets spécifiques à cette machine.
- `modules/darwin/apps.nix`: Liste des applications à installer sur macOS. 
- `modules/darwin/dock.nix`: Configuration du Dock. Permet de personnaliser l'apparence et le comportement du Dock.
- `modules/darwin/fonts.nix`: Configuration des polices. Gère l'installation et la configuration des polices de caractères.
- `modules/darwin/system.nix`: Configuration système. Contient les paramètres globaux du système, comme les préférences de sécurité et de performance.
- `modules/home-manager/zsh.nix`: Configuration de ZSH avec Home Manager. Personnalise le shell ZSH avec des plugins et des thèmes.
- `README.md`: Ce fichier. Contient des informations sur la structure et l'utilisation du projet.

## Utilisation

```sh
nix flake update --commit-lock-file

darwin-rebuild switch --flake ~/nix.#emacs
```

## Ressources

- [Documentation Nix](https://nixos.org/manual/nix/stable/)
- [Documentation Home Manager](https://nix-community.github.io/home-manager/)
- [Nix Flakes](https://nixos.wiki/wiki/Flakes)
- [Get all parameters](file:///nix/store/c831ggd6ncv1ks2mf32ngan4sq5p1kyb-darwin-manual-html/share/doc/darwin/index.html)
- [Nix darwin Wiki](https://daiderd.com/nix-darwin/manual/index.html)
- [Nix flakes (unofficial) manual](https://nixos-and-flakes.thiscute.world/)