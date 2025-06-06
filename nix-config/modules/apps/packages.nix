{ pkgs, username,... }: {
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
    brave
    obsidian-export
    utm
    python313
    python313Packages.pip
    python313Packages.isort
    pipenv
    python313Packages.pytest
    python314
    python311Full
    nodejs_22
    uv
    darwin.PowerManagement
    jetbrains.idea-ultimate
    maccy
    monitorcontrol
    tree
    _7zz
    code-cursor
    cargo
    rustc
    cmake
    libtool
    clang
    imagemagick
    ghostscript
    wget
    aria2
    xcodes
    docker
    colima
    google-chrome
    qbittorrent
    obsidian
    mysql80
    texliveFull
    vlc-bin-universal
    git
    biber
  ];
}