{ pkgs, ... }:
let
  fontData = import ../data/fonts.nix { inherit pkgs; };
in {
  fonts.packages = fontData.fontPackages;
}
