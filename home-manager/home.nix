# HomeManager Default Module

{ ... }:

{
  imports = [
    ./home-manager-modules/default.nix
  ];

  home.stateVersion = "24.11";

  home = {
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake .#";
      rebuild-boot = "sudo nixos-rebuild boot --flake .#";
      cdc = "cd ~/nixos-config";
      gitroot = "cd $(git rev-parse --show-toplevel)";
      gr = "gitroot";
      google_drive_upload = "rclone copy ~/Documents jujodeve:";
      gdu = "google_drive_upload";
    };
  };

  # programs.bash = {
  #   enable = true;
  #   initExtra = ''colorscript -r'';
  # };

  programs.fish = {
    enable = true;
    interactiveShellInit = "fastfetch";
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

  programs.powerline-go.enable = true;

  programs.zoxide.enable = true;

}
