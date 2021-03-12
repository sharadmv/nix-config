{ pkgs ? import <nixpkgs>, stdenv, ... }:

with pkgs;
stdenv.mkDerivation {
  pname = "nm-applet";
  version = "0.1";
  nativeBuildInputs = [ intltool pkgconfig ];
  buildInputs = [
    autoconf
    gettext
    automake
    file
    libtool
    networkmanager
    libsecret
    gnome3.gtk
    libnotify
    libnma
    libappindicator
    dbus_glib
    gnome3.libgudev
    libselinux
    makeWrapper
    dconf
    gnome2.GConf
  ];
  src = fetchFromGitHub {
    owner = "NetworkManager";
    repo = "network-manager-applet";
    rev = "1.21.0-dev";
    sha256 = "1fqjgjxwkr8s5caj0pkvd0w5vf7f1gxnsxq8alna0adcffz23y6l";
  };
  propagatedUserEnvPkgs = [
    gnome2.GConf
  ];
  configureFlags = [
    "--without-wwan"
    "--without-team"
  ];
  makeFlags = [
    "-j 5"
  ];
  postPatch = ''
    ./autogen.sh --without-wwan --without-team
  '';
  preFixup = ''
    wrapProgram "$out/bin/nm-applet" \
      --prefix GIO_EXTRA_MODULES : "${glib_networking}/lib/gio/modules:${dconf}/lib/gio/modules" \
      --prefix XDG_DATA_DIRS : "${gnome3.gtk}/share:$out/share:$GSETTINGS_SCHEMAS_PATH" \
      --set GCONF_CONFIG_SOURCE "xml::~/.gconf" \
      --prefix PATH ":" "${gnome2.GConf}/bin"
    wrapProgram "$out/bin/nm-connection-editor" \
      --prefix XDG_DATA_DIRS : "${gnome3.gtk}/share:$out/share:$GSETTINGS_SCHEMAS_PATH"
  '';
}
