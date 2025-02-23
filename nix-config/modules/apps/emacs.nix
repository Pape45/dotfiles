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

  system.activationScripts.postUserActivation.text = ''
    sudo -u ${username} bash <<'EOF'
      if [ ! -d "$HOME/.emacs.d" ]; then
        echo "Installing Doom Emacs..."
        ${pkgs.git}/bin/git clone --depth 1 https://github.com/doomemacs/doomemacs "$HOME/.emacs.d"
        "$HOME/.emacs.d/bin/doom" install --no-config --no-env --no-fonts --no-hooks
      fi
EOF
  '';
}