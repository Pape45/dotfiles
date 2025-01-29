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
        autosuggestion.enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
        initExtra = ''
          # Git aliases
          alias gst='git status'
          alias ga='git add'
          alias gc='git commit'
          alias gp='git push'
          alias gl='git pull'
        '';
      };

      programs.starship = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          add_newline = true;
          character = {
            success_symbol = "[➜](bold green)";
            error_symbol = "[➜](bold red)";
          };
        };
      };
    };
  };
}