{ config, pkgs, username, ... }: {
  programs.zsh.enable = true;
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Required for user-specific options like dock, finder, homebrew, etc.
  system.primaryUser = username;

  environment.variables = {
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };

  power.sleep = {
    display = 5;
  };

  networking.applicationFirewall = {
    enable = true;
    blockAllIncoming = false;
  };

  services.emacs.enable = false;

  system.activationScripts.postActivation.text = ''
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
