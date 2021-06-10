# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  rtl8812au = config.boot.kernelPackages.callPackage drivers/wifi/rtl8812au.nix {};
  sddm-theme = pkgs.callPackage dm/theme.nix {};
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.extraModulePackages = [
    rtl8812au
  ];
  boot.kernelModules = [ "8812au" ];

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.enableIPv6 = false;
  networking.networkmanager.enable = true;
  networking.hostName = "rocinante";
  networking.useDHCP = false;
  networking.interfaces.enp3s0.useDHCP = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  nix.allowedUsers = [ "@wheel" ];
  users.users.sharad = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "audio" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  programs.nm-applet.enable = true;
  programs.fish.enable = true;
  programs.steam.enable = true;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with unstable; [
    (pkgs.steam.override { extraLibraries = pkgs: [ pkgs.pipewire ]; })
    git
    wget
    vim
    tmux
    gnumake
    pciutils
    inxi
    powerline-fonts
    feh
    sddm-theme
    qt5.qtgraphicaleffects
    papirus-icon-theme
    gnome3.adwaita-icon-theme
    gmrun
    adwaita-qt
    gnome3.adwaita-icon-theme
    hicolor-icon-theme
    qgnomeplatform
    qt5.qtwayland
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FantasqueSansMono" "Iosevka" "Hermit" ]; })
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk
    comfortaa
    dejavu_fonts
  ];

  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.theme = "deepin";
    displayManager.defaultSession = "my-xmonad";
    libinput = {
      enable = true;
    };
    displayManager.session = [
      {
        manage = "desktop";
        name = "my-xmonad";
        start = ''exec $HOME/.xsession'';
      }
    ];

    videoDrivers = ["nvidia"];
  };

  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.ports = [ 322 ];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8000 8080 8888 3000 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

