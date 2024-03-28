# share configuration

{ config, pkgs, ... }:

{
  home-manager.backupFileExtension = "backup";

  home-manager.users.jotix = { pkgs, ... }:
  {
    home = {
      stateVersion = "23.11";
      username = "jotix";
      homeDirectory = "/home/jotix";
    };

      home.packages = with pkgs; [
        jetbrains-mono
        ubuntu_font_family
        nerdfonts
      ];

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };

    programs.powerline-go.enable = true;

    programs.bash = {
      enable = true;
      initExtra = "neofetch #colorscript --random";
    };

    programs.eza = {
      enable = true;
      enableBashIntegration = true;
      icons = true;
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

    
    programs.kitty = {
      enable = true;
      font = {
        name = "Jetbrains Mono";
        size = 10;
      };
      settings = {
        background_opacity = "0.9";
      };
      keybindings = {
        "ctrl+." = "change_font_size all +2.0";
        "ctrl+," = "change_font_size all -2.0";
        "ctrl+t" = "new_tab_with_cwd";
        "ctrl+left" = "next_tab";
        "ctrl+right" = "previous_tab";
        "ctrl+w" = "close_tab";
      };
    };
    
  };
}
