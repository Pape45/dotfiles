{ pkgs }: {
  fontPackages = with pkgs; [
    emacs-all-the-icons-fonts
    nerd-fonts.fira-code
  ];
}
