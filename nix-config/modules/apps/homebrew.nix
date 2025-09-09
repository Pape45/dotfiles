{ config, pkgs, ... }:

{
  # Homebrew packages
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    brews = [
      # Add brew packages here when needed
    ];

    taps = [ 
      "homebrew/bundle" 
      "homebrew/cask-fonts" 
      "homebrew/services" 
    ];

    casks = [
      # Add cask applications here when needed
    ];

    masApps = {
      # Add Mac App Store applications here when needed
      # Format: "App Name" = app_id;
    };
  };
}
