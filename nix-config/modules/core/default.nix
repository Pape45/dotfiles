{ config, pkgs, lib, ... }: {
  imports = [
    ./system.nix
    ./security.nix
    ./fonts.nix
    ../system/nix.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowInsecurePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "openclaw"
      ];
  };
}
