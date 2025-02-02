{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    emacs 
    git
    ripgrep
    coreutils-prefixed
    coreutils
    fd
    clang
    shellcheck
    fontconfig
    pandoc
    emacs-all-the-icons-fonts
    emacsPackages.gcmh
    emacsPackages.so-long
  ];


  environment.systemPath = [ 
    "$HOME/.emacs.d/bin"
    "${pkgs.emacs}/bin"
  ];

  environment.variables = {
    DOOMDIR = "$HOME/dotfiles/doom.d";
  };


  system.activationScripts.postUserActivation.text = ''
    # Switch to the user's context
    sudo -u papemamadoudiagne bash <<'EOF'
      # Check if Doom is already installed
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