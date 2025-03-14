### Bash Module

{
  config,
  lib,
  ...
}:

{
  options.bash.enable = lib.mkEnableOption "Enable bash shell";

  config = lib.mkIf (config.bash.enable) {

    programs.bash = {
      enable = true;
      initExtra = ''colorscript -r'';
    };

    home.shell.enableBashIntegration = true;

    programs.powerline-go.enable = true;

  };
}
