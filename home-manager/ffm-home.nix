{ lib, pkgs, ... }:

{
  home.stateVersion = "24.11";
  
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false; # enables user extensions
        enabled-extensions = [
          pkgs.gnomeExtensions.dash-to-dock.extensionUuid
        ];
      };

      "org/gnome/nautilus/icon-view".default-zoom-level = "small";
      "org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-type = "nothing";
      "org/gnome/desktop/session".idle-delay = lib.hm.gvariant.mkUint32 480;
      "org/gnome/desktop/screensaver".lock-enabled = false;
      "org/gnome/desktop/notifications".show-banners = false;
      "org/gnome/desktop/wm/preferences".button-layout = "appmenu:minimize,maximize,close";
      "org/gnome/shell".favorite-apps = [
        "google-chrome.desktop"
      ];

    };
  };
  
}
