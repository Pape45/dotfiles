{ pkgs, ... }: {
  system.defaults.dock.persistent-apps = [
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
}