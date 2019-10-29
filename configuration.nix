{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
  ];

  networking.extraHosts =
    ''
    '';

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  swapDevices = [
    {
      device = "/swapfile";
      size = 16384;
    }
  ];

  networking.hostName = "xps-nixos"; 
  networking.networkmanager.enable = true;  

  security.pam.services.gdm.enableGnomeKeyring = true;

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;

  hardware.nitrokey.enable = true;

  i18n = {
    consoleFont = "latarcyrheb-sun32";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Berlin";

  environment.systemPackages = with pkgs; [
    gksu
    wget 
    (import ./vim.nix)
    gawk
    python
    owncloud-client
    nitrokey-app
    chromium
    firefox
    pass
    git 
    gnupg
    docker_compose
    fzf
    tmux
    cryptsetup
    ccrypt
    dhcpcd
    bind
    file
    htop
    ack
    virtmanager
    pwgen
    neomutt
    offlineimap
    msmtp
    lynx
    urlview
    cifs_utils

    gnome3.libgnome-keyring
    gnome3.gnome-keyring
  ];

  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.adb.enable = true;

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = false;
  services.xserver.desktopManager.gnome3.enable = true;

  gnome3 = {
    gnome-keyring.enable = true;
    seahorse.enable = true;
  };

  services.xserver.libinput.enable = true;

  users.users.tarn = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "adbusers" ];
  };

  system.stateVersion = "19.09";
}
