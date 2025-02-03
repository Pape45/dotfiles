{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    jetbrains-mono
    emacs-all-the-icons-fonts
  ];
}