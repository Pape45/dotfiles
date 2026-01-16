{ username, ... }:
{
  home.stateVersion = "24.11";
  home.username = username;
  home.homeDirectory = "/Users/${username}";

  home.sessionPath = [
    "$HOME/.emacs.d/bin"
  ];
}

