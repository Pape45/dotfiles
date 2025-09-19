{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    emacs-all-the-icons-fonts
    nerd-fonts.fira-code
    jetbrains-mono
  ];
}