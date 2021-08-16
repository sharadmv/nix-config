{ pkgs, ... }:
let
  gitsigns-nvim = pkgs.vimUtils.buildVimPlugin  {
    pname = "gitsigns-nvim";
    version = "2021-10-30";
    src = pkgs.fetchFromGitHub {
      owner = "lewis6991";
      repo = "gitsigns.nvim";
      rev = "d12442a924dc431467149f1fcb33e1c648116803";
      sha256 = "0gpnp3vp0418hhjlwdawxc7slyh6p8pmdvycjm6rmyr0xjxx7ipm";
    };
    configurePhase = ''
    echo skip
    '';
    buildPhase = ''
    echo skip
    '';
    buildInputs = with pkgs; [
      luarocks
    ];
  };
  plenary-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "plenary-nvim";
    version = "2021-10-30";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-lua";
      repo = "plenary.nvim";
      rev = "96e821e8001c21bc904d3c15aa96a70c11462c5f";
      sha256 = "0y05pwc4kbjqgj1zjjhvmrll3d53wz55zgqavxd4bvj2gwhvnd2k";
    };
    meta.homepage = "https://github.com/nvim-lua/plenary.nvim/";
    buildInputs = with pkgs; [
      neovim
    ];
    buildPhase = ''
    echo skip
    '';
  };
  telescope-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "telescope-nvim";
    version = "2021-10-30";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope.nvim";
      rev = "d7f09f58954495d1373f3a400596b2fed71a8d1c";
      sha256 = "1gvr4fxpj7cz0jl4qcvpprh72asjsvlkpl0q3c4gdz9q7n2ar9aw";
    };
    meta.homepage = "https://github.com/nvim-telescope/telescope.nvim/";
    buildInputs = with pkgs; [
      neovim
    ];
    buildPhase = ''
    echo skip
    '';
  };
  dex-vim = pkgs.vimUtils.buildVimPlugin  {
    pname = "dex-vim";
    src = ../../../workspace/hack/dex-vim;
  };
in
with pkgs.vimPlugins;
[
  ayu-vim
  fzf-vim
  gitsigns-nvim
  indent-blankline-nvim
  kommentary
  nvim-compe
  nvim-lspconfig
  nvim-tree-lua
  nvim-treesitter
  nvim-web-devicons
  plenary-nvim
  telescope-nvim
  vim-beancount
  vim-nix
  vista-vim
]

