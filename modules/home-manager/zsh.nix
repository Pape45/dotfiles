{ pkgs, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.papemamadoudiagne = { pkgs, ... }: {
      home.stateVersion = "23.11";
      home.username = "papemamadoudiagne";
      home.homeDirectory = "/Users/papemamadoudiagne";

      programs.zsh = {
        enable = true;
        oh-my-zsh = {
          enable = true;
          plugins = [ "git" ];
          theme = "af-magic";
        };
        initExtra = '''';
      };
    };
  };
}