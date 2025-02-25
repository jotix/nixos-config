# default configuration

{ pkgs, ... }:

{
  imports = [
    ./modules/default.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "pipe-operators"
  ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11";

  ### graphics drivers ########################################################
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  ### keyboard layout
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };

  ### boot #####################################################################
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.consoleMode = "auto";
    efi.canTouchEfiVariables = true;
  };

  ### networking ###############################################################
  networking = {
    networkmanager = {
      enable = true;
      dns = "none";
    };
    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
    ];
  };

  ### locale #################################################################
  time.timeZone = "America/Argentina/Buenos_Aires";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "es_AR.UTF-8/UTF-8"
  ];

  i18n.extraLocaleSettings = {
    LANG = "en_US.UTF-8";
    LANGUAGE = "en_US.UTF-8";
    LC_ALL = "es_AR.UTF-8";
  };

  ### users ####################################################################
  users = {
    users.jotix = {
      isNormalUser = true;
      description = "jotix";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
      ];
    };
    defaultUserShell = pkgs.bash;
  };

  ### servicess ################################################################

  ### pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # services.flatpak.enable = true;

  ### packages #################################################################
  environment.systemPackages = with pkgs; [
    exfat
    exfatprogs
    ntfs3g
    usbutils
    pciutils
    gnumake
    cmake
    gcc
    nixd
    nixfmt-rfc-style
    zip
    unzip
    p7zip
    killall
    wget
    fastfetch
    wlr-randr
    mpv
    htop
    fuse
    wl-clipboard
    xclip
    virtiofsd
    gparted
    qmk
    qmk-udev-rules
    vial
    spotify
    gimp
    rclone
    libreoffice
    inkscape
    python3
    ventoy-full
    transmission_3
    transmission_3-qt
    ghostscript
    firefox
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    fira-code
    nerd-fonts.fira-code
    ubuntu_font_family
  ];

  programs = {
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      #pinentryPackage = pkgs.pinentry-curses;
    };
    fuse.userAllowOther = true;
    dconf.enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  ### virtualizations ##########################################################
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull.fd ];
        };
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };
  programs.virt-manager = {
    enable = true;
    package = pkgs.virt-manager;
  };
  #virtualisation.tpm.enable = true;

}
