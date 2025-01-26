{
  description = "Pape Darwins System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, mac-app-util}:
  let
    configuration = { pkgs, ... }: {
      
      nixpkgs.config.allowUnfree = true;
      programs.zsh.enable = true;
      security.pam.enableSudoTouchIdAuth = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [ 
          pkgs.vim
	        pkgs.oh-my-zsh
          pkgs.vscode
          pkgs.gh
          pkgs.stats
          pkgs.aldente
          pkgs.git
      ];

      imports = [
        mac-app-util.darwinModules.default
      ];
      
      # Fonts
      fonts.packages = [
        pkgs.nerd-fonts.fira-code
        pkgs.jetbrains-mono
      ];
      
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#emacs
    darwinConfigurations."emacs" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
