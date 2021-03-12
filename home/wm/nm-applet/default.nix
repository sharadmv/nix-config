{pkgs ? import <nixpkgs> {} }:

pkgs.callPackage ./nm-applet.nix {}
