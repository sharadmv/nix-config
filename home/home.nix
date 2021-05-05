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
  dex = pkgs.callPackage ../../workspace/hack/dex-lang { };
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


  nixpkgs.overlays = [
    (self: super: {
      discord = super.discord.overrideAttrs (_: {
        src = builtins.fetchTarball "https://discordapp.com/api/download?platform=linux&format=tar.gz";
      });
    })
  ];

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
  blur-background-exclude = [
    "class_g = 'slop'"
  ];
  shadow-exclude = [
    "class_g *?= 'slop'"
  ];
  '';

  home.packages = with pkgs; [
    _1password
    alacritty
    any-nix-shell
    bat
    betterlockscreen
    bind
    cava
    dex
    discord
    firefox
    fish
    font-awesome-ttf
    fortune
    fzf
    gimp
    gnome3.cheese
    gnome3.gnome-calendar
    gnome3.gnome-screenshot
    gnome3.networkmanagerapplet
    haskell-language-server
    htop
    jq
    libnotify
    lmms
    maim
    material-design-icons
    myFonts.icomoon-feather
    myPicom
    myRofi
    myVim
    myXMonad
    neofetch
    nodejs
    pasystray
    pavucontrol
    playerctl
    ripgrep
    sl
    spotify
    unity3d
    unityhub
    unzip
    vlc
    xautolock
    xclip
    xmonad-log
    xorg.xdpyinfo
    xorg.xkill
    zoom-us
  ];

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.rofi.enable = true;
  programs.git = {
    enable = true;
    userName = "Sharad Vikram";
    userEmail = "sharad.vikram@gmail.com";
    extraConfig.core.editor = "vim";
    extraConfig.init.defaultBranch = "main";
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
