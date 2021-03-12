{ pkgs, stdenv, ... }:

with pkgs;
stdenv.mkDerivation {
  name = "picom";
  buildInputs = [
    git
    meson
    libev
    xorg.libX11
    pkgconfig
    cmake
    xorg.xcbutilrenderutil
    xorg.xcbutilimage
    xorg.libXext
    pixman
    uthash
    libconfig
    pcre
    libGL
    dbus
    ninja
  ];
  src = fetchgit {
    deepClone = true;
    url = "https://github.com/ibhagwan/picom.git";
    rev = "60eb00ce1b52aee46d343481d0530d5013ab850b";
    sha256 = "0mcffb7mgwmwva9ny8593s1bbkpki593pj8wz826il267rwb86r8";
  };
  preConfigure = ''
  git submodule update --init --recursive
  '';
}
