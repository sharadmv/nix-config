{ callPackage, mkDerivation, base, dbus, lib, utf8-string, X11 
}:
let
  xmonad = callPackage ./xmonad.nix {};
  xmonad-contrib = callPackage ./xmonad-contrib.nix {};
  xmonad-extras = callPackage ./xmonad-extras.nix {};
in
  mkDerivation {
    pname = "my-xmonad";
    version = "0.1.0.0";
    src = ./.;
    isLibrary = false;
    isExecutable = true;
    executableHaskellDepends = [
      base dbus utf8-string X11 xmonad xmonad-extras
      xmonad-contrib
    ];
    license = "unknown";
    hydraPlatforms = lib.platforms.none;
  }
