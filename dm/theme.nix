{ pkgs, stdenv, ...}:

with pkgs;
stdenv.mkDerivation rec {
  pname = "sddm-deepin";
  version = "0.3";
  src = fetchFromGitHub {
    owner = "Match-Yang";
    repo = "sddm-deepin";
    rev = "6d018d2cad737018bb1e673ef4464ccf6a2817e7";
    sha256 = "1ghkg6gxyik4c03y1c97s7mjvl0kyjz9bxxpwxmy0rbh1a6xwmck";
  };
  
  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -aR $src/deepin $out/share/sddm/themes/deepin
  '';
  
}
