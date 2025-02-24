### zed Module

{ config, lib, ... }:

{
  options.zed.enable = lib.mkEnableOption "Enable zed editor";

  config = lib.mkIf (config.zed.enable) {

    programs.zed-editor = {
      enable = true;
      extensions = [
        "nix"
      ];
      userSettings = {
        ui_font_size = 16;
        buffer_font_size = 14;
        theme = {
          mode = "system";
          light = "One Light";
          dark = "One Dark";
        };
        buffer_font_family = "JetBrains Mono";
        terminal = {
          font_family = "JetBrains Mono";
          line_height = "standard";
        };
        tab_size = 2;
        formatter = "language_server";
      };
    };

  };
}
