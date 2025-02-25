### kde-settings Module

{
  config,
  lib,
  osConfig,
  ...
}:
let
  panelThickness = if (osConfig.networking.hostName == "jtx-nixos") then 56 else 44;
  panelLengthMode = if (osConfig.networking.hostName == "jtx-nixos") then 1 else 0;
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
      };

      "plasma-org.kde.plasma.desktop-appletsrc".Containments."2".Applets."5".Configuration.General.launchers =
        "applications:systemsettings.desktop,applications:org.kde.dolphin.desktop,applications:kitty.desktop,applications:firefox.desktop,applications:org.kde.kcalc.desktop,applications:zed.desktop,applications:steam.desktop";

      plasmashellrc = {
        PlasmaViews."Panel 2" = {
          panelLengthMode = panelLengthMode;
        };

        PlasmaViews."Panel 2".Defaults.thickness = panelThickness;
      };
    };

  };
}
