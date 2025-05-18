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

  system.activationScripts.doomEmacs.text = ''
    # Install Doom Emacs if it doesn't exist
    if [ ! -d "/Users/${username}/.emacs.d" ]; then
      echo "Installing Doom Emacs..."
      sudo -u ${username} ${pkgs.git}/bin/git clone --depth 1 https://github.com/doomemacs/doomemacs "/Users/${username}/.emacs.d"
      sudo -u ${username} "/Users/${username}/.emacs.d/bin/doom" install --no-config --no-env --no-fonts --no-hooks
    fi
  '';

  system.activationScripts.doomEmacsSync.text = ''
  # Vérifier si Emacs est installé et a changé
  if [ -L /run/current-system/sw/bin/emacs ]; then
    echo "Synchronizing Doom Emacs configuration..."
    sudo -u ${username} bash -c 'export PATH="/run/current-system/sw/bin:/Users/${username}/.emacs.d/bin:$PATH"; /Users/${username}/.emacs.d/bin/doom sync -u'
  fi
'';
}