### Helix Module

{ config, lib, ... }:

{
  options.helix.enable = lib.mkEnableOption "Enable Helix text editor";

  config = lib.mkIf (config.helix.enable) {

    programs.helix = {
      enable = true;
      settings = {
        theme = "tokyonight_storm";
        editor.line-number = "relative";
        keys.normal.esc = [
          "collapse_selection"
          "keep_primary_selection"
        ];
      };
      defaultEditor = true;
    };
    home.shellAliases = {
      vi = "hx";
      vim = "hx";
      nvim = "hx";
    };
  };

}
