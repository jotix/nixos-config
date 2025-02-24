# HomeManager Default Module

{ ... }:

{
  imports = [
    ./home-manager-modules/default.nix
  ];

  home.stateVersion = "24.11";

  programs.bash = {
    enable = true;
    initExtra = ''fastfetch'';
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
