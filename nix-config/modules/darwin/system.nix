{ self, ... }: {
  system.defaults.finder.FXPreferredViewStyle = "Nlsv";
  nix.settings.experimental-features = "nix-command flakes";
  programs.zsh.enable = true;
  system.configurationRevision = null;
  system.stateVersion = 5;
  nixpkgs.hostPlatform = "aarch64-darwin";
}