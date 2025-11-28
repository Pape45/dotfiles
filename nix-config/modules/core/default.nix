{ config, pkgs, ... }: {
  imports = [
    ./system.nix
    ./security.nix
    ./fonts.nix
    ../system/nix.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
