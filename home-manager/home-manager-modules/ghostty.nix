### Ghostty Module

{ config, lib, ... }:

{
  options.ghostty.enable = lib.mkEnableOption "Enable ghostty terminal emulator";

  config = lib.mkIf (config.ghostty.enable) {

    programs.ghostty = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        font-size = 10;
        window-height = 48;
        window-width = 140;
      };
    };

  };
}
