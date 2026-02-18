{ pkgs, username, ... }: {
  imports = [ ];

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };
}