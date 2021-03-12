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


  programs.home-manager.enable = true;
  programs.rofi.enable = true;

  xsession = {
    enable = true;
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

  services.screen-locker = {
    enable = true;
    lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen -l";
    enableDetectSleep = true;
    inactiveInterval = 20;
  };

  home.homeDirectory = homeDir;
  home.username = user;
  home.file.".config/xmonad/build".source = ./wm/xmonad/build;
  home.file = {
    ".face.icon".source = ./wallpapers/bird.png;
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
  '';


  home.packages = with pkgs; [
    unzip
    alacritty
    libnotify
    firefox
    _1password
    htop
    fortune
    myVim
    fish
    myXMonad
    pavucontrol
    pasystray
    xorg.xkill
    discord
    myRofi
    zoom-us
    gnome3.networkmanagerapplet
    font-awesome-ttf
    gnome3.gnome-calendar
    material-design-icons
    myFonts.icomoon-feather
    xmonad-log
    spotify
    myPicom
    cava
    any-nix-shell
    maim
    xclip
    neofetch
    playerctl
    vlc
    xautolock
    xorg.xdpyinfo
    betterlockscreen
    gimp
  ];
  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    userName = "Sharad Vikram";
    userEmail = "sharad.vikram@gmail.com";
    extraConfig.core.editor = "vim";
  };


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
}
