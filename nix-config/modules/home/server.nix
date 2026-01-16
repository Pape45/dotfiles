{ pkgs, username, ... }:
{
  # Home Manager on non-NixOS Linux (Ubuntu VPS).
  targets.genericLinux.enable = true;

  home.stateVersion = "25.11";
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    btop
    curl
    fd
    fzf
    git
    htop
    jq
    ripgrep
    tree
    unzip
    wget
    zip
    fail2ban
  ];

  programs.tmux.enable = true;
}
