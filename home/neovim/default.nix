{ pkgs ? import <nixpkgs> {}, ... }:

let
  plugins = (import ./plugins.nix pkgs);
in
{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];
  programs.neovim = {
    enable = true;
    withPython3 = true;
    vimAlias = true;
    extraConfig = ''
      lua << EOF

      ${builtins.readFile ./lua/init.lua}
      EOF
    '';
    plugins = plugins;
  };
}
