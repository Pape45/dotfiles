{ config, pkgs, lib, ... }:

let
  doom-emacs-dir = "${config.users.users.papemamadoudiagne.home}/.emacs.d";
  doom-config-dir = "${config.users.users.papemamadoudiagne.home}/.doom.d";
in {
  environment.systemPackages = with pkgs; [
    emacs
    git
    ripgrep
    fd
    imagemagick
    zstd
    editorconfig-core-c
    clang-tools
    (aspellWithDicts (ds: with ds; [ en en-computers en-science ]))
  ];

  system.activationScripts.installDoomEmacs = ''
    if [ ! -d "${doom-emacs-dir}" ]; then
      ${pkgs.git}/bin/git clone --depth=1 --single-branch \
        "https://github.com/doomemacs/doomemacs" "${doom-emacs-dir}"
      
      # Install Doom Emacs
      ${doom-emacs-dir}/bin/doom install --force
    fi
  '';

  environment.systemPath = [ "${doom-emacs-dir}/bin" ];
}