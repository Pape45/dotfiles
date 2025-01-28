{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ 
    vim
    vscode
    gh
    stats
    aldente
    anki-bin
    ffmpeg_6
    uv
    yt-dlp
    arc-browser
    jdk
    firefox-unwrapped
    iina
    jetbrains.idea-ultimate
    maccy
    monitorcontrol
    obsidian
    the-unarchiver
    utm
  ];
}