{ config, pkgs, lib, desktop, ... }:

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
    ./ssh
    ./tmux
    ./neovim
  ];

  home.packages = import ./packages.nix {
    inherit pkgs;
    inherit desktop;
  };

  home.homeDirectory = homeDir;
  home.username = user;
  home.file = {
    ".direnvrc".source = ./direnvrc;
  };
  home.file = {
    ".config/htop/htoprc".source = ./htop/htoprc;
  };
  fonts.fontconfig.enable = true;

  programs = {
    home-manager.enable = true;
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
