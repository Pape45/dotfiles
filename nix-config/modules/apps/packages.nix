{ pkgs, ... }:
let
  pkgData = import ../data/system-packages.nix { inherit pkgs; };
in {
  environment.systemPackages = pkgData.systemPackages;
}
