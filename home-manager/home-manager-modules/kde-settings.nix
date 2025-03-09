### kde-settings Module

{
  config,
  lib,
  ...
}:

let
  jotix-profile = ''
    [Appearance]
    Font=JetBrains Mono,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1

    [General]
    Name=jotix
    Parent=FALLBACK/

    [Scrolling]
    ScrollBarPosition=2
  '';

in

{
  options.kde-settings.enable = lib.mkEnableOption "Enable kde-settings";

  config = lib.mkIf (config.kde-settings.enable) {

    qt.kde.settings = {
      kdeglobals.KDE = {
        SingleClick = true;
        LookAndFeelPackage = "org.kde.breezedark.desktop";
      };

      powerdevilrc.AC.SuspendAndShutdown.AutoSuspendAction = 0;

      katerc = {
        General."Show Menu Bar" = false;
      };

      plasma-localerc = {
        Formats = {
          LANG = "en_US.UTF-8";
          LC_ADDRESS = "es_AR.UTF-8";
          LC_MEASUREMENT = "es_AR.UTF-8";
          LC_MONETARY = "es_AR.UTF-8";
          LC_NAME = "es_AR.UTF-8";
          LC_NUMERIC = "es_AR.UTF-8";
          LC_PAPER = "es_AR.UTF-8";
          LC_TELEPHONE = "es_AR.UTF-8";
          LC_TIME = "es_AR.UTF-8";
        };

        konsolerc = {
          "Desktop Entry" = {
            DefaultProfile = "jotix.profile";
          };
        };

        home.file.".local/share/konsole/jotix.profile" = jotix-profile;
      };

    };

  };
}
