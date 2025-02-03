{ config, username, ... }: {
  imports = [
    ./home.nix
  ];

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };
}