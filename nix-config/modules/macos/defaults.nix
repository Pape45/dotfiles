{ pkgs, ... }:
let
  dockApps = (import ../data/dock-apps.nix { inherit pkgs; }).persistentApps;
in {
  system.defaults = {
    dock = {
      show-recents = false; # no recent apps in Dock
      mru-spaces = false; # keep Spaces order stable
      largesize = 24;
      wvous-bl-corner = 1; # disable hot corners
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
      persistent-apps = dockApps;
    };

    WindowManager = {
      EnableStandardClickToShowDesktop = false; # disable wallpaper click-to-desktop
    };

    screencapture = {
      location = "/Users/papemamadoudiagne/Downloads";
    };

    finder = {
      AppleShowAllExtensions = true;
      FXDefaultSearchScope = "SCcf"; # search current folder by default
      FXPreferredViewStyle = "Nlsv"; # list view
      NewWindowTarget = "Home";
      CreateDesktop = false; # hide desktop icons
      ShowPathbar = true;
      ShowRemovableMediaOnDesktop = false;
      ShowStatusBar = true;
    };

    hitoolbox = {
      AppleFnUsageType = "Do Nothing"; # Fn key does nothing (avoids dictation/input swap)
    };

    loginwindow = {
      GuestEnabled = false;
    };

    trackpad = {
      Clicking = true; # tap to click
      TrackpadRightClick = true;
      TrackpadThreeFingerDrag = false;
      TrackpadThreeFingerTapGesture = 0; # disable lookup tap
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
      AirDrop = false; # hide from menu bar
      BatteryShowPercentage = false;
    };
  };
}
