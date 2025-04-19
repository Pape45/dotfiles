{ config, pkgs, ... }: {
  imports = [
    ./packages.nix
    #./emacs.nix
    ./dock.nix
  ];
}