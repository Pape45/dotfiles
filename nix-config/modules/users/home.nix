{ pkgs, username, inputs, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = { pkgs, ... }: {
      imports = [
        # inputs..s-util.homeManagerModules.default
      ];
      home.stateVersion = "24.11";
      home.username = username;
      home.homeDirectory = "/Users/${username}";

      home.sessionPath = [
        "$HOME/.emacs.d/bin"
        #"$HOME/development/flutter/bin"
        #"$HOME/.gem/ruby/3.3.0/bin"
        #"/usr/local/go/bin"
        #"$HOME/.pub-cache/bin"
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
          core = {
            excludesfile = "~/.gitignore_global";
            editor = "vim";
          };
          pull.rebase = true;
          init.defaultBranch = "main";
          rebase.autostash = true;
          push.autoSetupRemote = true;
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
          force = true;
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
        
        # Remove non-Doom ~/.emacs.d to avoid conflicts
        if [ -d "$HOME/.emacs.d" ] && [ ! -d "$HOME/.emacs.d/.git" ]; then
          $DRY_RUN_CMD echo "Removing non-Doom .emacs.d directory..."
          $DRY_RUN_CMD rm -rf "$HOME/.emacs.d"
        fi
        
        # Clone Doom Emacs if missing
        if [ ! -d "$HOME/.emacs.d/.git" ]; then
          $DRY_RUN_CMD echo "Cloning Doom Emacs..."
          $DRY_RUN_CMD ${pkgs.git}/bin/git clone --depth 1 https://github.com/doomemacs/doomemacs "$HOME/.emacs.d"
        fi
        
        # Install Doom if not initialized yet
        if [ ! -d "$HOME/.emacs.d/.local/etc/@" ]; then
          $DRY_RUN_CMD echo "Installing Doom Emacs..."
          $DRY_RUN_CMD yes | $HOME/.emacs.d/bin/doom install --env
        else
          # Doom is installed -> always sync to keep things up to date
          $DRY_RUN_CMD echo "Syncing Doom Emacs..."
          $DRY_RUN_CMD $HOME/.emacs.d/bin/doom sync
        fi
        
        # Check whether a Doom upgrade reminder is needed (last upgrade > 30 days)
        UPGRADE_MARKER="$HOME/.emacs.d/.last-doom-upgrade"
        DAYS_THRESHOLD=30
        
        if [ -f "$UPGRADE_MARKER" ]; then
          LAST_UPGRADE=$(cat "$UPGRADE_MARKER")
          CURRENT_DATE=$(date +%s)
          DAYS_SINCE=$(( (CURRENT_DATE - LAST_UPGRADE) / 86400 ))
          
          if [ "$DAYS_SINCE" -ge "$DAYS_THRESHOLD" ]; then
            echo ""
            echo "╔══════════════════════════════════════════════════════════════╗"
            echo "║  DOOM EMACS UPGRADE REMINDER                                 ║"
            echo "║                                                              ║"
            echo "║  Last upgrade: $DAYS_SINCE days ago                                   ║"
            echo "║                                                              ║"
            echo "║  Run: ~/.emacs.d/bin/doom upgrade                            ║"
            echo "║                                                              ║"
            echo "║  After upgrading, mark as done:                              ║"
            echo "║  date +%s > ~/.emacs.d/.last-doom-upgrade                    ║"
            echo "╚══════════════════════════════════════════════════════════════╝"
            echo ""
          fi
        else
          # Create the marker file on first run
          $DRY_RUN_CMD date +%s > "$UPGRADE_MARKER"
        fi
      '';
    };
  };
}
