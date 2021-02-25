{pkgs, stdenv, ...}:

with pkgs;
stdenv.mkDerivation {
  name = "vim";
  builder = "${bash}/bin/bash";
  buildInputs = [ gnumake gnused pkg-config ];
  src = fetchFromGitHub {
    owner = "vim";
    repo = "vim";
    rev = "v8.2.2549";
    sha256 = "03sndqi28q81jcf1f5z9nchgj79klmqcpjaqhc4vp9zysjj4vl12";
  };
  args = [ ./builder.sh ];
  system = builtins.currentSystem;
}
