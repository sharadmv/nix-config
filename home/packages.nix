{ pkgs, fonts, picom, rofi, vim, xmonad }:
let
  dex = pkgs.callPackage ../../workspace/hack/dex-lang { };
in
with pkgs; [
    _1password
    alacritty
    any-nix-shell
    arandr
    bat
    betterlockscreen
    bind
    cava
    discord
    firefox
    fish
    font-awesome-ttf
    fonts.icomoon-feather
    fortune
    fzf
    gimp
    gnome3.cheese
    gnome3.gnome-calendar
    gnome3.gnome-screenshot
    gnome3.networkmanagerapplet
    google-chrome
    haskell-language-server
    htop
    jq
    killall
    libnotify
    lmms
    maim
    material-design-icons
    ncdu
    neofetch
    nodejs
    pasystray
    pavucontrol
    picom
    playerctl
    rclone
    ripgrep
    rofi
    service-wrapper
    sl
    spotify
    unzip
    wineWowPackages.staging
    # winetricks and other programs depending on wine need to use the same wine version
    (winetricks.override { wine = wineWowPackages.staging; })
    vim
    vlc
    xautolock
    xclip
    xmonad
    xmonad-log
    xorg.xdpyinfo
    xorg.xkill
    zoom-us
]
