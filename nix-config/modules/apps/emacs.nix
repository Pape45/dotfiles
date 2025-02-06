{ pkgs, username, ... }: {
  environment.systemPackages = with pkgs; [
    emacs
    ripgrep
    coreutils-prefixed
    coreutils
    emacs-all-the-icons-fonts
    fd
    clang
    shellcheck
    pandoc
    emacsPackages.gcmh
    fontconfig
  ];

  environment.systemPath = [ 
    "$HOME/.emacs.d/bin"
    "${pkgs.emacs}/bin"
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