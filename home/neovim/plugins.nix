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
  nvim-lspfuzzy = pkgs.vimUtils.buildVimPlugin  {
    name = "nvim-lspfuzzy";
    src = pkgs.fetchFromGitHub {
      owner = "ojroques";
      repo = "nvim-lspfuzzy";
      rev = "b8653dd8ecf6c10c96a06dba6bc5ef71ff72abb6";
      sha256 = "17g5xx7vblvksr58pa8p54cdia6n1cz7g44xhdkj8nay08dvasyv";
    };
  };
  gitsigns-nvim = pkgs.vimUtils.buildVimPlugin  {
    name = "gitsigns-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "lewis6991";
      repo = "gitsigns.nvim";
      rev = "main";
      sha256 = "0vrb900p2rc323axb93hc7jwcxg8455zwqsvxm9vkd2mcsdpn33w";
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
    version = "2021-08-13";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-lua";
      repo = "plenary.nvim";
      rev = "0b78fe699b9049b8f46942664027b32102979832";
      sha256 = "16ghyvnsqdrfkjb7hawcvwrx56v6llnq4zziw4z1811j4n1v6ypa";
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
    version = "2021-08-13";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope.nvim";
      rev = "f1a27baf279976845eb43c65e99a71d7f0f92d02";
      sha256 = "069r1pkg82zj7fm55gk21va2f2x2jmrknfwld5bp0py344gh65n1";
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
    name = "dex-vim";
    src = ../../../workspace/hack/dex-vim;
  };
in
with pkgs.vimPlugins;
[
  ayu-vim
  gitsigns-nvim
  indent-blankline-nvim
  nvim-compe
  nvim-lspconfig
  nvim-tree-lua
  nvim-treesitter
  nvim-web-devicons
  plenary-nvim
  telescope-nvim
  vim-nix
  vista-vim
  fzf-vim
]

