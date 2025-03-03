### gnome-settings Module

{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  bookmarks = ''
    file:///home/jotix/Documents
    file:///home/jotix/Music
    file:///home/jotix/Pictures
    file:///home/jotix/Videos
    file:///home/jotix/Downloads
  '';
  ventoy = ''file:///mnt/Ventoy Ventoy'';
  jtx-nixos-bookmarks = ''
    file:///mnt/jtx-ssd jtx-ssd
    file:///mnt/jtx-nvme jtx-nvme
  '';
  hostname = osConfig.networking.hostName;
  online-accounts = ''
    [Account account_1741011330_0]
    Provider=google
    Identity=jujodeve@gmail.com
    PresentationIdentity=jujodeve@gmail.com
    MailEnabled=true
    CalendarEnabled=true
    ContactsEnabled=true
    FilesEnabled=true

    [Account account_1741011389_1]
    Provider=google
    Identity=infofilofem@gmail.com
    PresentationIdentity=infofilofem@gmail.com
    MailEnabled=true
    CalendarEnabled=true
    ContactsEnabled=true
    FilesEnabled=true
  '';
in
{
  options.gnome-settings.enable = lib.mkEnableOption "Enable gnome-settings";

  config = lib.mkIf (config.gnome-settings.enable) {

    dconf = {
      enable = true;
      settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false; # enables user extensions
          enabled-extensions = [
            # Put UUIDs of extensions that you want to enable here.
            # If the extension you want to enable is packaged in nixpkgs,
            # you can easily get its UUID by accessing its extensionUuid
            # field (look at the following example).
            pkgs.gnomeExtensions.tiling-assistant.extensionUuid
            pkgs.gnomeExtensions.dash-to-dock.extensionUuid

            # Alternatively, you can manually pass UUID as a string.
            # "blur-my-shell@aunetx"
            # ...
          ];
        };

        "org/gnome/nautilus/icon-view".default-zoom-level = "small";
        "org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-type = "nothing";
        "org/gnome/desktop/interface".color-scheme = "prefer-dark";
        "org/gnome/desktop/session".idle-delay = lib.hm.gvariant.mkUint32 480;
        "org/gnome/desktop/screensaver".lock-enabled = false;
        "org/gnome/desktop/notifications".show-banners = false;
        "org/gnome/desktop/wm/preferences".button-layout = "appmenu:minimize,maximize,close";
        "org/gnome/Console".last-window-size = lib.hm.gvariant.mkTuple [
          1200
          900
        ];
        "org/gnome/shell".favorite-apps = [
          "google-chrome.desktop"
          "org.gnome.Nautilus.desktop"
          "emacs.desktop"
          "org.gnome.Settings.desktop"
          "org.gnome.Extensions.desktop"
          "dev.zed.Zed.desktop"
          "com.mitchellh.ghostty.desktop"
          "steam.desktop"
          "org.gnome.Calculator.desktop"
          "org.gnome.tweaks.desktop"
          "chrome-knipfmibhjlpioflafbpemngnoncknab-Default.desktop"
        ];

      };
    };

    xdg.configFile = {
      "gtk-3.0/bookmarks" = {
        enable = true;
        text =
          if hostname == "virt-nixos" then
            bookmarks
          else if hostname == "ffm-nixos" then
            bookmarks ++ ventoy
          else
            bookmarks ++ jtx-nixos-bookmarks ++ ventoy;
      };

      "goa-1.0/accounts.conf" = {
        enable = true;
        text = online-accounts;
      };
    };

  };

}
