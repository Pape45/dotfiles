{ config, pkgs, ... }: {
  imports = [
    ./packages.nix
    ./emacs.nix
    ./homebrew.nix
    #./postgresql.nix --- broken, fix exists, I'll try later, just use docker :)
  ];
}
