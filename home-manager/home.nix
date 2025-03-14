# HomeManager Default Module

{ ... }:

{
  imports = [
    ./modules/default.nix
  ];

  home.stateVersion = "24.11";

  home = {
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake .#";
      rebuild-boot = "sudo nixos-rebuild boot --flake .#";
      cdc = "cd ~/workspace/nixos-config";
      gitroot = "cd $(git rev-parse --show-toplevel)";
      gr = "gitroot";
      google_drive_upload = "rclone copy ~/Documents jujodeve:";
      gdu = "google_drive_upload";
      zed = "zeditor";
    };
  };

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    icons = "auto";
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };

  programs.git = {
    enable = true;
    userName = "jotix";
    userEmail = "jujodeve@gmail.com";
    ignores = [
      "*~"
      "*.swp"
      "*~undo-tree~"
      "#*"
    ];
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.lazygit.enable = true;

  programs.zoxide.enable = true;

}
