{ pkgs, desktop }:
with pkgs; [
  any-nix-shell
  fishPlugins.foreign-env
  font-awesome
  fortune
  fzf
  htop
  jq
  neofetch
  pyright
  ripgrep
  unzip
] ++ (lib.lists.optionals desktop [
])
