{ callPackage, mkDerivation, base, bytestring, containers, directory, fetchgit
, filepath, hspec, lib, mtl, process, QuickCheck, random, time
, unix, utf8-string, X11, X11-xft
}:
let
  xmonad = callPackage ./xmonad.nix {};
in
  mkDerivation {
    pname = "xmonad-contrib";
    version = "0.16.999";
    src = fetchgit {
      url = "https://github.com/xmonad/xmonad-contrib.git";
      sha256 = "01wpp4xykjjfh5b81x4nr5p74vnwabnpvx2wcyzzsk5gn23j4yfl";
      rev = "04713d2e9c0d2a42b69df3e6024ad419da0700bf";
      fetchSubmodules = true;
    };
    libraryHaskellDepends = [
      base bytestring containers directory filepath mtl process random
      time unix utf8-string X11 X11-xft xmonad
    ];
    testHaskellDepends = [
      base containers directory hspec mtl process QuickCheck random time
      unix utf8-string X11 xmonad
    ];
    homepage = "http://xmonad.org/";
    description = "Third party extensions for xmonad";
    license = lib.licenses.bsd3;
  }
