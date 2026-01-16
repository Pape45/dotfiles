{ pkgs, username, inputs, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    # Pass through extra args to Home Manager modules.
    extraSpecialArgs = { inherit inputs username; };

    users.${username} = { pkgs, ... }: {
      imports = [
        ../home/common.nix
        ../home/darwin.nix
        ../home/doom.nix
      ];
    };
  };
}
