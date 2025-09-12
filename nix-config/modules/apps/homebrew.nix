{ config, pkgs, inputs, username, ... }: {
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
      # Command line tools
    ];
    
    casks = [
      "font-fira-code"
      "font-jetbrains-mono"
    ];
    
    masApps = {
      # Mac App Store applications
    };
    
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}