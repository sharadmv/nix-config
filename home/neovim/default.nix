{ pkgs ? import <nixpkgs> {}, ... }:

let
  plugins = (import ./plugins.nix pkgs);
in
{
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
