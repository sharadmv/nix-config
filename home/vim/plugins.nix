{ pkgs, ... }:
let
  jupytext-vim = pkgs.vimUtils.buildVimPlugin  {
    name = "jupytext.vim";
    src = pkgs.fetchFromGitHub {
      owner = "goerz";
      repo = "jupytext.vim";
      rev = "v0.1.2";
      sha256 = "1kgh6iqh5yc536mxbhj6c1412zm2c7cn8si4v5kcv0imb8v14s0w";
    };
  };
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
  jupytext-vim
  molokai
  nerdcommenter
  nerdtree
  semshi
  sensible
  vim-beancount
  vim-gitgutter
  vim-highlightedyank
  vim-lastplace
  vim-nix
  vim-numbertoggle
  vim-toml
  vista-vim
]

