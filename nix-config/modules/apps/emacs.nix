{ pkgs, username, ... }: {
  environment.systemPackages = with pkgs; [
    emacs
    git
    ripgrep
    coreutils-prefixed
    coreutils
    emacs-all-the-icons-fonts
    fd
    clang
    shellcheck
    pandoc
    emacsPackages.gcmh
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

      # Ensure doom.d directory exists in dotfiles
      if [ ! -d "$HOME/dotfiles/doom.d" ]; then
        echo "Creating doom.d directory..."
        mkdir -p "$HOME/dotfiles/doom.d"
        cp -r $HOME/.doom.d/* "$HOME/dotfiles/doom.d/" || true
      fi
EOF
  '';
}