{
  description = "Pape's Darwin System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # mac-app-util.url = "github:hraban/mac-app-util";
    
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, nix-homebrew, homebrew-core, homebrew-cask, ... }:
    let
      username = "papemamadoudiagne";
    in {
      darwinConfigurations = {
        emacs = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = { inherit inputs username; };
          modules = [
            ./modules/core
            ./modules/apps
            ./modules/users
            ./modules/macos/defaults.nix
            ./hosts/emacs
            home-manager.darwinModules.home-manager
            # mac-app-util.darwinModules.default
            nix-homebrew.darwinModules.nix-homebrew
          ];
        };
      };
    };
}
