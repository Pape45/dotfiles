{ config, pkgs, ... }: {
  imports = [
    ./system.nix
    ./security.nix
    ./fonts.nix
  ];

  nixpkgs.config.allowUnfree = true;
}