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

  system.defaults = {
    screensaver = {
      askForPassword = true;
      askForPasswordDelay = 0;
    };

    dock = {
      show-recents = false;
      mru-spaces = false;
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
    };

    WindowManager = {
      EnableStandardClickToShowDesktop = false;
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
  };

  services.emacs.enable = false;

  # Activation script for immediate updates
  system.activationScripts.postUserActivation.text = ''
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}