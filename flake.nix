{
  description = "Pape Darwins System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, mac-app-util, home-manager}:
    let
      username = "papemamadoudiagne";
      homeDirectory = "/Users/papemamadoudiagne";
    in {
      darwinConfigurations."emacs" = nix-darwin.lib.darwinSystem {
        modules = [ 
          ./hosts/emacs
          home-manager.darwinModules.home-manager
        ];
      };
    };
}