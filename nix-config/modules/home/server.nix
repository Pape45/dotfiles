{ pkgs, username, ... }:
{
  # Home Manager on non-NixOS Linux (Ubuntu VPS).
  targets.genericLinux.enable = true;

  home.stateVersion = "25.11";
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    bat
    btop
    curl
    eza
    fd
    fzf
    git
    htop
    jq
    ripgrep
    tmux
    tree
    unzip
    wget
    zip
  ];

  programs.tmux.enable = true;
}
