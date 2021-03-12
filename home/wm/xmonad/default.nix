{ pkgs ? import <nixpkgs> {} }:

pkgs.callPackage ./xmonad.nix {}
