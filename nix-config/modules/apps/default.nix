{ config, pkgs, ... }: {
  imports = [
    ./packages.nix
    ./emacs.nix
    ./homebrew.nix
    ./postgresql.nix
  ];
}
