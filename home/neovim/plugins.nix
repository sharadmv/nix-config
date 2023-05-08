{ pkgs, ... }:
with pkgs.vimPlugins; [
  ayu-vim
  cmp-nvim-lsp
  fzf-vim
  gitsigns-nvim
  indent-blankline-nvim
  feline-nvim
  fidget-nvim
  kanagawa-nvim
  kommentary
  nvim-cmp
  nvim-lspconfig
  nvim-tree-lua
  (nvim-treesitter.withPlugins (
    plugins: with plugins; [
      tree-sitter-python
    ]))
  nvim-web-devicons
  plenary-nvim
  telescope-nvim
  barbar-nvim
  vim-beancount
  vim-nix
  vista-vim
  trouble-nvim
  which-key-nvim
]

