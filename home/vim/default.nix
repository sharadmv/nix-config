{ pkgs ? import <nixpkgs> {} }:

pkgs.callPackage ./vim.nix {}
