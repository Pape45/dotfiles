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
        "$HOME/.pub-cache/bin"
      ];

      home.sessionVariables = {
        LANG = "en_US.UTF-8";
        LC_ALL = "en_US.UTF-8";
      };

      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "Pape Mamadou Diagne";
            email = "66137298+Pape45@users.noreply.github.com";
          };
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
          theme = "candy";
        };

        syntaxHighlighting.enable = true;
      };

      home.file = {
        ".doom.d" = {
          source = ../../../doom.d;
          recursive = true;
          onChange = ''
            export PATH="${pkgs.emacs}/bin:${pkgs.git}/bin:$HOME/.emacs.d/bin:$PATH"
            if [ -x "$HOME/.emacs.d/bin/doom" ]; then
              echo "Synchronizing Doom Emacs configuration..."
              $HOME/.emacs.d/bin/doom sync
              $HOME/.emacs.d/bin/doom env
            fi
          '';
        };
      }; 

      home.activation.doomEmacs = inputs.home-manager.lib.hm.dag.entryAfter ["writeBoundary"] ''
        export PATH="${pkgs.emacs}/bin:${pkgs.git}/bin:$HOME/.emacs.d/bin:$PATH"
        
        # Supprimer .emacs.d si ce n'est pas Doom
        if [ -d "$HOME/.emacs.d" ] && [ ! -d "$HOME/.emacs.d/.git" ]; then
          $DRY_RUN_CMD echo "Removing non-Doom .emacs.d directory..."
          $DRY_RUN_CMD rm -rf "$HOME/.emacs.d"
        fi
        
        # Clone Doom Emacs si absent
        if [ ! -d "$HOME/.emacs.d/.git" ]; then
          $DRY_RUN_CMD echo "Cloning Doom Emacs..."
          $DRY_RUN_CMD ${pkgs.git}/bin/git clone --depth 1 https://github.com/doomemacs/doomemacs "$HOME/.emacs.d"
        fi
        
        # Installer Doom si jamais initialisé
        if [ ! -d "$HOME/.emacs.d/.local/etc/@" ]; then
          $DRY_RUN_CMD echo "Installing Doom Emacs..."
          $DRY_RUN_CMD yes | $HOME/.emacs.d/bin/doom install --env
        else
          # Doom est installé -> toujours sync pour s'assurer que tout est à jour
          $DRY_RUN_CMD echo "Syncing Doom Emacs..."
          $DRY_RUN_CMD $HOME/.emacs.d/bin/doom sync
        fi
      '';
    };
  };
}