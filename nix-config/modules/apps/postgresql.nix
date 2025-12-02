{ pkgs, ... }: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    
    # Not yet supported by nix darwin
    ensureDatabases = [
    ];
    
    # Not yet supported by nix darwin
    ensureUsers = [
    ];
    
    # Configuration optionnelle
    settings = {
      log_connections = true;
      log_disconnections = true;
    };
  };
}
