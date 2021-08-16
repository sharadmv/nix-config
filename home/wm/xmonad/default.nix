{ pkgs ? import <nixpkgs> {} }:

pkgs.haskellPackages.callPackage ./my-xmonad.nix {}
