{ pkgs, username, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = { pkgs, ... }: {
      home.stateVersion = "23.11";
      home.username = username;
      home.homeDirectory = "/Users/${username}";

      programs.zsh = {
        enable = true;
        autosuggestion = {
          enable = true;
        };
        enableCompletion = true;
        syntaxHighlighting.enable = true;
          initExtra = ''
          # Git aliases
          alias gst='git status'
          alias ga='git add'
          alias gc='git commit'
          alias gcsc='git commit -m "Small changes"'
          alias gp='git push'
          alias gpm = 'git push origin main'
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

      home.file = {
        ".doom.d" = {
          source = ../../../doom.d;
          recursive = true;
          onChange = ''
            export PATH="${pkgs.emacs}/bin:${pkgs.git}/bin:$HOME/.emacs.d/bin:$PATH"
            $HOME/.emacs.d/bin/doom sync
            $HOME/.emacs.d/bin/doom env
          '';
        };
      }; 
    };
  };
}