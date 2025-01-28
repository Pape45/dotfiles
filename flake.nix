{
  description = "Pape Darwins System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, mac-app-util}:
  let
    configuration = { pkgs, ... }: {

      imports = [
        mac-app-util.darwinModules.default
      ];
      
      nixpkgs.config.allowUnfree = true;
      security.pam.enableSudoTouchIdAuth = true;

      environment.systemPackages = with pkgs; [ 
        vim
        #oh-my-zsh
        vscode
        gh
        stats
        aldente
        anki-bin
        ffmpeg_6
        uv
        yt-dlp
        arc-browser
        #code-cursor
        jdk
        firefox-unwrapped
        iina
        jetbrains.idea-ultimate
        maccy
        monitorcontrol
        obsidian
        #portfolio
        #stremio
        the-unarchiver
        utm
      ];

      
      # Fonts
      fonts.packages = [
        pkgs.nerd-fonts.fira-code
        pkgs.jetbrains-mono
      ];

      # MacOs Settings
      system.defaults = {
        dock.persistent-apps = [
          "/Applications/Safari.app"
          "${pkgs.firefox-unwrapped}/Applications/Firefox.app"
          "/System/Applications/Messages.app"
          "/System/Applications/Mail.app"
          "/System/Applications/Calendar.app"
          "/System/Applications/Notes.app"
          "/System/Applications/TV.app"
          "${pkgs.vscode}/Applications/Visual Studio Code.app"
          "/System/Applications/App Store.app"
          "/System/Applications/System Settings.app"
          "${pkgs.obsidian}/Applications/Obsidian.app"
          "/System/Applications/Utilities/Terminal.app"
          "${pkgs.anki-bin}/Applications/Anki.app"
        ];

        finder.FXPreferredViewStyle = "Nlsv";
      };
      
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable shell
      programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#emacs
    darwinConfigurations."emacs" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
