{ pkgs ? import <nixpkgs>, stdenv, ...}:

let 
  launcherCommand = "rofi -no-lazy-grab -show drun -modi drun -theme $out/launchers/colorful/style_1";
  colors = builtins.readFile ./colors.rasi;
  powerCommand = builtins.readFile ./powermenu;
in
with pkgs;
stdenv.mkDerivation {
  pname = "rofi-themes";
  version = "0.1";
  src = fetchFromGitHub {
    owner = "adi1090x";
    repo = "rofi";
    rev = "aba9eb3d1ad67ade0fdb89b7e4998e69c873a86f";
    sha256 = "R1RegMYiUrKYKiFD1esU3n4YahFlD0XGwflL7ls5rtc=";
  };
  postConfigure = ''
    rm 1080p/launchers/colorful/launcher.sh
    echo "${colors}" > 1080p/launchers/colorful/colors.rasi
    '';
  installPhase = ''
    cp -aR 1080p $out
    rm -rf $out/bin/*
    echo '${powerCommand}' > $out/bin/powermenu
    echo -e "#!/bin/bash\n${launcherCommand}" >> $out/bin/launcher
    chmod +x $out/bin/launcher
    chmod +x $out/bin/powermenu
  '';
}
