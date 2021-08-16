{ pkgs ? import <nixpkgs> {}, ... }:

let
  plugins = (import ./plugins.nix pkgs);
in
{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/0f574809bca4045f90d078e0f29f89f24b0563f0.tar.gz;
    }))
  ];
  
  xdg.configFile."nvim/lua".source = ./lua;
  programs.neovim = {
    enable = true;
    withPython3 = true;
    vimAlias = true;
    extraConfig = ''
      lua << EOF
      require('init')
      EOF
    '';
    plugins = plugins;
  };
}
