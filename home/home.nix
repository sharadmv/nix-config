{ config, pkgs, lib, ... }:

let
  user = "sharad";
in
let
  homeDir = "/home/${user}";
  configDir = "config";
in
{
  # Let Home Manager install and manage itself.
  imports = [
    ./fish
  ];
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.homeDirectory = homeDir;
  home.username = user;
  home.file = {
    ".tmux.conf".source = ./tmux.conf;
  };


  home.packages = with pkgs; [
    _1password
    htop
    fortune
    poetry
    (callPackage ./vim {})
  ];

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
