{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim
    vscode
    gh
    stats
    aldente
    anki-bin
    ffmpeg_6
    yt-dlp
    arc-browser
    jdk
    firefox-unwrapped
    iina
    obsidian
    the-unarchiver
    utm
    python314
    nodejs_22
    uv
    python313
    python313Packages.pip
    python311Full
    darwin.PowerManagement
    jetbrains.idea-ultimate
    maccy
    monitorcontrol
    tree
  ];
}