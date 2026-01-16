{
  description = "Pape's macOS + VPS (Home Manager) configuration";

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
      mkPkgs = system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

      macUsername = "papemamadoudiagne";
      vpsUsername = "ubuntu";
    in {
      darwinConfigurations = {
        emacs = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = { inherit inputs; username = macUsername; };
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

      # Standalone Home Manager for non-NixOS machines (e.g. Ubuntu VPS).
      homeConfigurations = {
        "ubuntu@papevnic" = home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs "x86_64-linux";
          extraSpecialArgs = { inherit inputs; username = vpsUsername; };
          modules = [
            ./modules/home/common.nix
            ./modules/home/server.nix
            ./hosts/papevnic/home.nix
          ];
        };
      };
    };
}
