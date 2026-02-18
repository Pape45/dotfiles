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
      # Your VPS reports `aarch64-linux`. If you migrate to an x86_64 VPS later,
      # switch this to "x86_64-linux".
      vpsSystem = "aarch64-linux";
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
      homeConfigurations =
        let
          vpsHome = home-manager.lib.homeManagerConfiguration {
            pkgs = mkPkgs vpsSystem;
            extraSpecialArgs = { inherit inputs; username = vpsUsername; };
            modules = [
              ./modules/home/common.nix
              ./modules/home/server.nix
            ];
          };
        in {
          # Use this so you never have to update commands when the VPS hostname changes.
          vps = vpsHome;

          # Convenience alias for the current VPS name.
          "ubuntu@pipavnic" = vpsHome;
        };
    };
}
