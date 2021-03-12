{ pkgs ? import <nixpkgs> {} }:


let src = pkgs.fetchFromGitHub {
    owner = "taffybar";
    repo = "status-notifier-item";
    rev = "fe6fddc6827635a5c9cc450e502dcd28b11d7fba";
    sha256 = "1qn5376w1sl4c1lln6n0nx7i57vcc0hvc5fmijf2k4vvjrc55113";
  };
in
  pkgs.haskellPackages.callCabal2nix "status-notifier-item" "${src}" { }
