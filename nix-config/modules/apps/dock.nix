{ pkgs, username, ... }: {
  system.defaults.dock = {
    persistent-apps =  [
      "/System/Applications/Launchpad.app" 
      "/Applications/Safari.app"
      "/System/Applications/Messages.app"
      "/System/Applications/Mail.app"
      "/System/Applications/Calendar.app"
      "/System/Applications/Notes.app"
      "${pkgs.vscode}/Applications/Visual Studio Code.app"
      "/System/Applications/App Store.app"
      "/System/Applications/System Settings.app"
      "${pkgs.obsidian}/Applications/Obsidian.app"
      "/System/Applications/Utilities/Terminal.app"
      "${pkgs.emacs}/Applications/Emacs.app"
      "${pkgs.anki-bin}/Applications/Anki.app"
    ];

    persistent-others = [
      "/Users/${username}/Documents"
      "/Users/${username}/Downloads"
    ];
  };
}