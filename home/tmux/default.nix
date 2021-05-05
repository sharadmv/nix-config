{ pkgs ? import <nixpkgs> {}, ... }:

let
  src = pkgs.fetchFromGitHub {
    owner = "gpakosz";
    repo = ".tmux";
    rev = "a752c41bca59622987e9a7275404893d7c9013eb";
    sha256 = "1p19y6cjy9jvaxf23pljy2lhqad8iqr3mrchc407ylwj572n8kaj";
    stripRoot = false;
  };
in
{
  home.file.".tmux.conf".text = builtins.readFile "${src}/.tmux-a752c41bca59622987e9a7275404893d7c9013eb/.tmux.conf";
  home.file.".tmux.conf.local".source = ./tmux.conf.local;
}

