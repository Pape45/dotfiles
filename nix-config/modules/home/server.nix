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
    openscap
    scap-security-guide
    caddy
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
    nodejs_22
    pnpm
    uv
    gh
    vim
    wrangler
    k6
    postgresql_16
    gnutar
    trivy
    semgrep
    fastfetch
  ];

  programs.tmux.enable = true;
}
