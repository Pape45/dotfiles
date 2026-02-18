{ pkgs, ... }:
{
  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Pape Mamadou Diagne";
        email = "66137298+Pape45@users.noreply.github.com";
      };
      core = {
        excludesfile = "~/.gitignore_global";
        editor = "vim";
      };
      pull.rebase = true;
      init.defaultBranch = "main";
      rebase.autostash = true;
      push.autoSetupRemote = true;
    };
  };

  home.file.".gitignore_global".text = ''
    # General
    .DS_Store
    .AppleDouble
    .LSOverride

    # Icon must end with two \r
    Icon

    # Thumbnails
    ._*

    # Files that might appear in the root of a volume
    .DocumentRevisions-V100
    .fseventsd
    .Spotlight-V100
    .TemporaryItems
    .Trashes
    .VolumeIcon.icns
    .com.apple.timemachine.donotpresent

    # Directories potentially created on remote AFP share
    .AppleDB
    .AppleDesktop
    Network Trash Folder
    Temporary Items
    .apdisk
  '';

  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "history"
        "colored-man-pages"
      ];
      theme = "candy";
    };

    syntaxHighlighting.enable = true;

    initContent = ''
      export PATH="$HOME/.local/bin:$PATH"
    '';
  };

  home.shellAliases = {
    ll = "ls -la";
    codex1 = "CODEX_HOME=$HOME/.codex-accounts/acc1 codex --dangerously-bypass-approvals-and-sandbox";
    codex2 = "CODEX_HOME=$HOME/.codex-accounts/acc2 codex --dangerously-bypass-approvals-and-sandbox";
    codex3 = "CODEX_HOME=$HOME/.codex-accounts/acc3 codex --dangerously-bypass-approvals-and-sandbox";
    codex4 = "CODEX_HOME=$HOME/.codex-accounts/acc4 codex --dangerously-bypass-approvals-and-sandbox";
    codex5 = "CODEX_HOME=$HOME/.codex-accounts/acc5 codex --dangerously-bypass-approvals-and-sandbox";
  };

  # Best UX for per-project dev envs on the VPS: `direnv` + `use flake`.
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
