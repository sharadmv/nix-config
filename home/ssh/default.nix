{ pkgs ? import <nixpkgs>, ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "pi" = {
        hostname = "192.168.1.159";
        user = "pi";
      };
    };
  };
}
