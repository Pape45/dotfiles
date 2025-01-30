{ pkgs, ... }: {
  imports = [
    ../../modules/darwin/apps.nix
    ../../modules/darwin/dock.nix
    ../../modules/darwin/fonts.nix
    ../../modules/darwin/system.nix
    ../../modules/darwin/emacs.nix
    ../../modules/home-manager/zsh.nix
  ];

  users.users.papemamadoudiagne = {
    name = "papemamadoudiagne";
    home = "/Users/papemamadoudiagne";
  };

  nixpkgs.config.allowUnfree = true;
  security.pam.enableSudoTouchIdAuth = true;
}