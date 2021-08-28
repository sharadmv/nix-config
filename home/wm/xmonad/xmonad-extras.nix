{ callPackage, mkDerivation, alsa-mixer, base, bytestring, containers, fetchgit
, hint, lib, libmpd, mtl, network, regex-posix, X11
}:
let
  xmonad = callPackage ./xmonad.nix {};
  xmonad-contrib = callPackage ./xmonad-contrib.nix {};
in
mkDerivation {
  pname = "xmonad-extras";
  version = "0.15.3";
  src = fetchgit {
    url = "https://github.com/xmonad/xmonad-extras.git";
    sha256 = "1kj8xzp7d8y0w63r46zvgav6a3320c6blsilaldaylgqb10h6aga";
    rev = "6df82de88474754bc90724251d5fcbeccccbd7e7";
    fetchSubmodules = true;
  };
  configureFlags = [
    "-f-with_hlist" "-fwith_parsec" "-fwith_split"
  ];
  libraryHaskellDepends = [
    alsa-mixer base bytestring containers hint libmpd mtl network
    regex-posix X11 xmonad xmonad-contrib
  ];
  homepage = "https://github.com/xmonad/xmonad-extras";
  description = "Third party extensions for xmonad with wacky dependencies";
  license = lib.licenses.bsd3;
}
