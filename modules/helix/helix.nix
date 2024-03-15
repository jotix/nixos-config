# helix

{ config, pkgs, ... }:

{
  home-manager.users.jotix = { pkgs, ... }:  {
    programs.helix = {
      enable = true;
      settings = {
        theme = "tokyonight_storm";
        editor.line-number = "relative";
        keys.normal.esc = ["collapse_selection" "keep_primary_selection"];
      };
      defaultEditor = true;
    };

    programs.bash.shellAliases = {
      vim = "hx";
      vi = "hx";
      nvim = "hx";
    };
  };
}
