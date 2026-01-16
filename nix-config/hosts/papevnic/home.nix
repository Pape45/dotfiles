{ username, ... }:
{
  home.stateVersion = "24.11";
  home.username = username;
  home.homeDirectory = "/home/${username}";
}

