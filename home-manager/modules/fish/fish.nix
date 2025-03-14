### Fish Module

{
  config,
  lib,
  ...
}:

{
  options.fish.enable = lib.mkEnableOption "Enable fish shell";

  config = lib.mkIf (config.fish.enable) {

    home.shell.enableFishIntegration = true;

    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        colorscript -r
      '';
    };

    xdg.configFile."fish/functions/fish_prompt.fish" = {
      enable = true;
      source = ./fish_prompt.fish;
    };
  };
}
