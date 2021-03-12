{ pkgs ? import <nixpkgs> {}, ... }:

{
  programs.neovim = {
    enable = true;
    withPython3 = true;
    vimAlias = true;
    extraConfig = builtins.readFile ../vim/vimrc;
    plugins = with pkgs.vimPlugins; [
      YouCompleteMe
      fugitive
      nerdtree
      molokai
      gruvbox
      nerdcommenter
      ctrlp-vim
      vim-numbertoggle
      vim-beancount
      sensible
      haskell-vim
    ];
  };
}
