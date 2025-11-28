{ pkgs, username, ... }: {
  system.defaults.dock = {
    persistent-apps = [
      { app = "/System/Applications/Apps.app"; }
      { app = "/Applications/Safari.app"; }
      { app = "/System/Applications/Messages.app"; }
      { app = "/System/Applications/Mail.app"; }
      { app = "/System/Applications/Calendar.app"; }
      { app = "/System/Applications/Notes.app"; }
      { app = "/System/Applications/App Store.app"; }
      { app = "/System/Applications/System Settings.app"; }
      { app = "/Applications/Visual Studio Code.app"; }
      { app = "/System/Applications/Utilities/Terminal.app"; }
      { app = "${pkgs.emacs}/Applications/Emacs.app"; }
      { app = "${pkgs.anki-bin}/Applications/Anki.app"; }
      { app = "${pkgs.obsidian}/Applications/Obsidian.app"; }
      { app = "${pkgs.brave}/Applications/Brave Browser.app"; }
    ];
  };
}