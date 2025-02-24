### Kitty Module

{ config, lib, ... }:

{
  options.kitty.enable = lib.mkEnableOption "Enable Kitty Terminal emulator";

  config = lib.mkIf (config.kitty.enable) {

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
