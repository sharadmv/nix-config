{pkgs, ...}:


let
  plugins = (import ./plugins.nix pkgs);
in
with pkgs;
(vim_configurable.override { python = python3; }).customize {
  name = "vim";
  vimrcConfig = {
    customRC = builtins.readFile ./vimrc;
  };

  vimrcConfig.packages.myVimPackage = with vimPlugins; {
    # loaded on launch
    start = plugins;
  };
}
