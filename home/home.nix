{ config, pkgs, lib, ... }:

let
  user = "sharad";
in
let
  homeDir = "/home/${user}";
  configDir = "config";

  myVim = (pkgs.callPackage ./vim {});
  myXMonad = (pkgs.callPackage ./wm/xmonad {});
  myFonts = pkgs.callPackage ./fonts { inherit pkgs; };
  myRofi = (pkgs.callPackage ./wm/rofi {});
  myPicom = (pkgs.callPackage ./wm/picom {});

  laptopBar = pkgs.callPackage wm/polybar/bar.nix {
    font0 = 10;
    font1 = 12;
    font2 = 24;
    font3 = 18;
    font4 = 5;
  };
  statusBar = import wm/polybar {
    inherit config pkgs;
    mainBar = laptopBar;
    openCalendar = "${pkgs.gnome3.gnome-calendar}/bin/gnome-calendar";
  };
  polybarOpts = ''
    feh --bg-fill $HOME/.wallpapers/elevator.jpg &
    ${pkgs.pasystray}/bin/pasystray &
    ${pkgs.blueman}/bin/blueman-applet &
    ${pkgs.gnome3.networkmanagerapplet}/bin/nm-applet --sm-disable --indicator &
  '';
in
{
  # Let Home Manager install and manage itself.
  imports = [
    ./fish
    ./ssh
    ./wm/dunst
    ./alacritty
    ./tmux
    ./neovim
    statusBar
  ];

  home.packages = import ./packages.nix {
    fonts = myFonts;
    picom = myPicom;
    pkgs = pkgs;
    rofi = myRofi;
    vim = myVim;
    xmonad = myXMonad;
  };

  nixpkgs.overlays = [
    (self: super: {
      discord = super.discord.overrideAttrs (_: {
        src = builtins.fetchTarball "https://discordapp.com/api/download?platform=linux&format=tar.gz";
      });
    })
  ];

  xsession = {
    enable = true;
    scriptPath = ".xsession-xmonad";
    windowManager.command = "xmonad";
    preferStatusNotifierItems = true;
    pointerCursor = {
      defaultCursor = "left_ptr";
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
    };
    initExtra = polybarOpts + ''
    ${myPicom}/bin/picom &
    '';
  };

  services = {
    screen-locker = {
      enable = true;
      lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen -l";
      xautolock = {
        detectSleep = true;
      };
      inactiveInterval = 20;
    };
    gnome-keyring.enable = true;
  };

  home.homeDirectory = homeDir;
  home.username = user;
  home.file.".config/xmonad/build".source = ./wm/xmonad/build;
  home.file = {
    ".face.icon".source = ./wallpapers/bird.png;
  };
  home.file = {
    ".face".source = ./wallpapers/bird.png;
  };
  home.file = {
    ".config/htop/htoprc".source = ./htop/htoprc;
  };
  home.file = {
    ".wallpapers".source = ./wallpapers;
  };
  home.file.".config/picom/picom.conf".text = ''
  backend = "glx";
  blur-method = "dual_kawase";
  blur-strength = 8;
  blur-background = true;
  blur-background-fixed = true;
  blur-background-exclude = [
    "class_g = 'slop'"
  ];
  shadow-exclude = [
    "class_g *?= 'slop'"
  ];
  '';

  fonts.fontconfig.enable = true;

  programs = {
    home-manager.enable = true;
    rofi.enable = true;
    git = {
      enable = true;
      userName = "Sharad Vikram";
      userEmail = "sharad.vikram@gmail.com";
      extraConfig.core.editor = "vim";
      extraConfig.init.defaultBranch = "main";
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  home.stateVersion = "21.03";
}
