{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation rec {
  pname = "adi1090x-plymouth";
  version = "0.0.1";

  src = pkgs.fetchFromGitHub {
    repo = "plymouth-themes";
    owner = "adi1090x";
    rev = "bf2f570bee8e84c5c20caac353cbe1d811a4745f";
    sha256 = "0scgba00f6by08hb14wrz26qcbcysym69mdlv913mhm3rc1szlal";
  };

  buildInputs = [
  ];

  configurePhase = ''
  mkdir -p $out/share/plymouth/themes/
  '';

  buildPhase = ''
  '';

  installPhase = ''
  cp -r pack_3/lone $out/share/plymouth/themes
cat pack_3/lone/lone.plymouth | sed  "s@\/usr\/@$out\/@" > $out/share/plymouth/themes/lone/lone.plymouth
  '';
}
