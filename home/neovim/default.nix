{ pkgs ? import <nixpkgs> {}, ... }:

let
  plugins = (import ./plugins.nix pkgs);
in
{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/7a899330a1acd9ed6b3783cdecd256105e408a20.tar.gz;
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
