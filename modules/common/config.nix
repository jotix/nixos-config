# share configuration

{ config, pkgs, ... }:

{

  nix = {
    package = pkgs.nixFlakes; # or versioned attributes like nixVersions.nix_2_8
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Bootloader
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
    };
  };

  boot.supportedFilesystems = [ "ntfs" ];

  # Enable networking
  networking = {
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };

  # enable virtualisation
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # Set your time zone.
  time.timeZone = "America/Argentina/Buenos_Aires";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_AR.UTF8";
    LC_IDENTIFICATION = "es_AR.UTF8";
    LC_MEASUREMENT = "es_AR.UTF8";
    LC_MONETARY = "es_AR.UTF8";
    LC_NAME = "es_AR.UTF8";
    LC_NUMERIC = "es_AR.UTF8";
    LC_PAPER = "es_AR.UTF8";
    LC_TELEPHONE = "es_AR.UTF8";
    LC_TIME = "es_AR.UTF8";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "altgr-intl";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;  
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jotix = {
    isNormalUser = true;
    description = "jotix";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.variables = {
    EDITOR = "nano";
    VISUAL = "nano";
  };

  # shellAliases
  environment.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake .#$HOSTNAME";
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    usbutils
    gnumake
    cmake
    gcc
    wl-clipboard
    xclip
    wget
    virt-manager
    gnucash
    gimp
    python311Full
    python311Packages.python-lsp-server
    qmk
    qmk-udev-rules
    qmk_hid
    zip
    unzip
    p7zip
    librecad
    libreoffice
    mpv
    gparted
    htop
    spotify
    fuse
    pass
    inkscape
    pciutils
    vial
    google-chrome
    firefox
    jetbrains-mono
    ubuntu_font_family
    neofetch
    nerdfonts
    dwt1-shell-color-scripts
    gnome.gnome-tweaks
    glade
    #racket  
    #guile
  ]; # ++ (with lib; filter isDerivation (attrValues pkgs.plasma5Packages.kdeGear)); ## for install all kde apps

  # steam
  #programs.steam.enable = true;
  #hardware.steam-hardware.enable = true;

  # bluetooth
  hardware.bluetooth.enable = true;

  # bash
  users.defaultUserShell = pkgs.bash;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "curses";
  };

  # fuse
  programs.fuse.userAllowOther = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable fstrim
  services.fstrim.enable = true;
  
  # Flatpak
  #services.flatpak.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leavecatenate(variables, "bootdev", bootdev)
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  hardware.keyboard.qmk.enable = true;
}
