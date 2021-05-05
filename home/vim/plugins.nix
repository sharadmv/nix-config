{ pkgs, ... }:
let
  dex-vim = pkgs.vimUtils.buildVimPlugin  {
    name = "dex-vim";
    src = ../../../workspace/hack/dex-vim;
  };
in
with pkgs.vimPlugins;
[
  ayu-vim
  coc-nvim
  coc-pyright
  dex-vim
  fugitive
  fzf-vim
  gruvbox
  haskell-vim
  molokai
  nerdcommenter
  nerdtree
  semshi
  sensible
  vim-beancount
  vim-gitgutter
  vim-rooter
  vim-highlightedyank
  vim-lastplace
  vim-nix
  vim-numbertoggle
  vim-toml
  vista-vim
]

