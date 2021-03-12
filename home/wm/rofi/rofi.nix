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
    rev = "9c4093c665326bb08d6affc7e16d18d8f25c4452";
    sha256 = "07b2hb12hibsqmqb16wg1hyaqkydg0bjg59q76ajgq7r8v6n0f1j";
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
