{ config, pkgs, ... }: {
  nix.settings.experimental-features = "nix-command flakes";
  programs.zsh.enable = true;
  system.stateVersion = 5;
  nixpkgs.hostPlatform = "aarch64-darwin";

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };

  nix.settings = {
    max-jobs = "auto";
  };

  nix.optimise.automatic = true;

  power.sleep = {
    display = 5;
  };

  system.defaults = {

    alf = {
      globalstate = 1;
    };

    dock = {
      show-recents = false;
      mru-spaces = false;
      largesize = 26;
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
    };

    WindowManager = {
      EnableStandardClickToShowDesktop = false;
    };

    screencapture = {
      location = "/Users/$(whoami)/Downloads";
    };

    finder = {
      AppleShowAllExtensions = true;
      CreateDesktop = false;
      FXDefaultSearchScope = "SCcf";
      ShowPathbar = true;
      ShowRemovableMediaOnDesktop = false;
      ShowStatusBar = true;
    };

    hitoolbox = {
      AppleFnUsageType = "Do Nothing";
    };

    loginwindow = {
      GuestEnabled = false;
    };

    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
      TrackpadThreeFingerDrag = false;
      TrackpadThreeFingerTapGesture = 0;
    };

    NSGlobalDomain = {
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      "com.apple.trackpad.trackpadCornerClickBehavior" = 1;
      "com.apple.mouse.tapBehavior" = 1;
    };
    
    CustomUserPreferences = {
        "com.apple.Safari" = {
        ShowOverlayStatusBar = true;
        AutoOpenSafeDownloads = false;
      };
    };

    controlcenter = {
      AirDrop = false;
      BatteryShowPercentage = false;

    };
  };

  services.emacs.enable = false;

  system.activationScripts.powerManagementSettings.text = ''
    echo "Configuring power management settings..."
    
    # Désactiver l'économiseur d'écran
    defaults -currentHost write com.apple.screensaver idleTime -int 0
    
    # Configuration des délais d'extinction de l'écran
    # Sur batterie: 2 minutes
    /usr/bin/pmset -b displaysleep 2
    
    # Sur secteur: 5 minutes 
    /usr/bin/pmset -c displaysleep 10
    
    # Demander le mot de passe immédiatement après la mise en veille de l'écran
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0
  '';

  # Activation script for immediate updates
  system.activationScripts.postUserActivation.text = ''
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}