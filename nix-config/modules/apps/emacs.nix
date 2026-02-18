{ pkgs, username, ... }: {
  environment.systemPackages = with pkgs; [
    emacs
    emacs-all-the-icons-fonts
    emacsPackages.gcmh
    ripgrep
    coreutils-prefixed
    coreutils
    fd
    shellcheck
    pandoc
    fontconfig
    python313Packages.python-lsp-server
  ];
}