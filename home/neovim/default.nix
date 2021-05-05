{ pkgs ? import <nixpkgs> {}, ... }:

let
  plugins = (import ../vim/plugins.nix pkgs);
in
{
  programs.neovim = {
    enable = true;
    withPython3 = true;
    vimAlias = true;
    extraConfig = builtins.readFile ../vim/vimrc;
    plugins = plugins;
  };

  xdg.configFile."nvim/coc-settings.json".text = builtins.readFile ../vim/coc-settings.json;
}
