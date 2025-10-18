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
    ];
    
    casks = [
      "visual-studio-code@insiders"
      "visual-studio-code"
      "adguard"
      "altserver"
      "microsoft-word"
      "microsoft-excel"
      "microsoft-powerpoint"
      "portfolioperformance"
      #"telegram"
      #"tor-browser"
      "orbstack"
      "ProtonVPN"
    ];
    
    masApps = {
      #"Amphetamine" = 937984704;  # App to keep your Mac awake
    };
    
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}