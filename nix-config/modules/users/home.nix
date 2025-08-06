{ pkgs, username, inputs, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = { pkgs, ... }: {
      imports = [
        inputs.mac-app-util.homeManagerModules.default
      ];
      home.stateVersion = "23.11";
      home.username = username;
      home.homeDirectory = "/Users/${username}";

      home.sessionPath = [
        "$HOME/.emacs.d/bin"
        "${pkgs.texliveFull}/bin"
        "$HOME/development/flutter/bin"
        "$HOME/.gem/ruby/3.3.0/bin"
        "${pkgs.cocoapods}/bin"
        "/usr/local/go/bin"
      ];

      home.sessionVariables = {
        LANG = "en_US.UTF-8";
        LC_ALL = "en_US.UTF-8";
        CHROME_EXECUTABLE = "${pkgs.google-chrome}/bin/google-chrome-stable";
      };

      programs.git = {
        enable = true;
        userName = "Pape Mamadou Diagne";
        userEmail = "66137298+Pape45@users.noreply.github.com";
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
        oh-my-zsh = {
          enable = true;
          plugins = [
            "git"
            "history"
            "colored-man-pages"
          ];
          theme = "avit";
        };

        syntaxHighlighting.enable = true;
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