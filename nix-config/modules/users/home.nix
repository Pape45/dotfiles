{ pkgs, username, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = { pkgs, ... }: {
      home.stateVersion = "23.11";
      home.username = username;
      home.homeDirectory = "/Users/${username}";

      programs.git = {
        enable = true;
        extraConfig = {
          core.excludesfile = "~/.gitignore_global";
        };
      };

      home.file.".gitignore_global" = {
        text = ''
          # General
          .DS_Store
          .AppleDouble
          .LSOverride

          # Icon must end with two \r
          Icon

          # Thumbnails
          ._*

          # Files that might appear in the root of a volume
          .DocumentRevisions-V100
          .fseventsd
          .Spotlight-V100
          .TemporaryItems
          .Trashes
          .VolumeIcon.icns
          .com.apple.timemachine.donotpresent

          # Directories potentially created on remote AFP share
          .AppleDB
          .AppleDesktop
          Network Trash Folder
          Temporary Items
          .apdisk
        '';
      };

      programs.zsh = {
        enable = true;
        prezto = {
          enable = true;
          pmodules = [
            "environment"
            "editor"
            "history"
            "directory"
            "utility"
            "spectrum"
            "completion"
            "prompt"
            "git"
            "syntax-highlighting"
            "history-substring-search"
          ];
          prompt.theme = "pure";
        };
      };

      # programs.starship = {
      #   enable = true;
      #   enableZshIntegration = true;
      #   settings = {
      #     add_newline = true;
      #     character = {
      #       success_symbol = "[➜](bold green)";
      #       error_symbol = "[➜](bold red)";
      #     };
      #   };
      # };

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