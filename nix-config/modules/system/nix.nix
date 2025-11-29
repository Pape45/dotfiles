{ ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };

  nix.settings = {
    max-jobs = "auto";
  };

  nix.optimise.automatic = true;
}
