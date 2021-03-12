{pkgs, ...}:


with pkgs;
(vim_configurable.override { python = python3; }).customize {
  name = "vim";
  vimrcConfig = {
    customRC = builtins.readFile ./vimrc;
  };

  vimrcConfig.packages.myVimPackage = with vimPlugins; {
    # loaded on launch
    start = [
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
