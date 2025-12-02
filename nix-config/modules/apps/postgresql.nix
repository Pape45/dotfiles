{ pkgs, ... }: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    
    # Créer automatiquement des bases de données si nécessaire
    ensureDatabases = [
      # "mydb"  # Ajoutez vos bases ici
    ];
    
    # Créer automatiquement des utilisateurs si nécessaire
    ensureUsers = [
      # {
      #   name = "myuser";
      #   ensurePermissions = {
      #     "DATABASE mydb" = "ALL PRIVILEGES";
      #   };
      # }
    ];
    
    # Configuration optionnelle
    settings = {
      log_connections = true;
      log_disconnections = true;
    };
  };
}
