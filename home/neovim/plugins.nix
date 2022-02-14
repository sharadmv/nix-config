{ pkgs, ... }:
let
  dex-vim = pkgs.vimUtils.buildVimPlugin {
    pname = "dex-vim";
    version = "2022-02-13";
    src = pkgs.fetchFromGitHub {
      owner = "sharadmv";
      repo = "dex-vim";
      rev = "1e6657ef2c114e0eaa5fa77aa03f83bbf1bcc4e2";
      sha256 = "EIHL04yWRlvLhCyeOsI15Fx+xhOMFGYcHrlmAjxD99s=";
    };
  };
in
with pkgs.vimPlugins; [
  ayu-vim
  cmp-nvim-lsp
  dex-vim
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
]

