# share configuration

{ config, pkgs, ... }:

let 
  homeDir = "/home/jotix";
  nextCloudDir = "/mnt/nextcloud";
in
{
  home-manager.backupFileExtension = "backup";

  home-manager.users.jotix = { pkgs, ... }:
  {
    home = {
      stateVersion = "23.11";
      username = "jotix";
      homeDirectory = homeDir;
    };

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      #desktop =     homeDir + "/Desktop";
      documents =   nextCloudDir + "/Documents";
      #download =    homeDir + "/Downloads";
      #music =       homeDir + "/Music";
      pictures =    nextCloudDir + "/Pictures";
      #publicShare = homeDir + "/Public";
      #templates =   homeDir + "/Templates";
      #videos =      homeDir + "/Videos";
    };

    programs.powerline-go.enable = true;

    programs.bash = {
      enable = true;
      initExtra = "colorscript --random";
    };

    programs.eza = {
      enable = true;
      enableAliases = true;
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

    /*
    programs.helix = {
      enable = true;
      settings = {
        theme = "tokyonight_storm";
        editor.line-number = "relative";
        keys.normal.esc = ["collapse_selection" "keep_primary_selection"];
      };
      defaultEditor = true;
    };
    */

    /*
    programs.kitty = {
      enable = true;
      font = {
        name = "Jetbrains Mono";
        size = 10;
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
    */

  };
}
