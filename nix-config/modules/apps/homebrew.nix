{ config, pkgs, inputs, username, ... }:
let
  caskData = import ../data/homebrew-casks.nix;
in {
  nix-homebrew = {
    enable = true;
    user = username;
    
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };
    
    mutableTaps = false;
  };

  homebrew = {
    enable = true;
    
    taps = builtins.attrNames config.nix-homebrew.taps;
    
    brews = [
      "neonctl"
      "mole"
      "poppler"
      "r"
    ];
    
    casks = caskData.casks;
    
    masApps = {
      "CrystalFetch ISO Downloader" = 6454431289;
      "Perplexity: Ask Anything" = 6714467650;
      "Aiko" = 1672085276;
    };
    
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}
