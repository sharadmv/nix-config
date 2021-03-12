{ pkgs, ... }:

{
  programs.alacritty.enable = true;
  xdg.configFile."alacritty/alacritty.yml".source = ./alacritty.yml;
  xdg.configFile."alacritty/dracula.yml".source = ./dracula.yml;
}

