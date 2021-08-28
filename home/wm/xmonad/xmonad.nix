{ mkDerivation, base, containers, data-default-class, directory
, fetchgit, filepath, lib, mtl, process, QuickCheck
, quickcheck-classes, setlocale, time, transformers, unix, X11
}:
mkDerivation {
  pname = "xmonad";
  version = "0.16.99999";
  src = fetchgit {
    url = "https://github.com/xmonad/xmonad.git";
    sha256 = "1y92l9j8mb28472zamwhb3avl0p2qgfrvsdvbkda7qizcz3kp3cm";
    rev = "aa18707c3ef96db88208509c2a18c6670e831661";
    fetchSubmodules = true;
  };
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base containers data-default-class directory filepath mtl process
    setlocale time transformers unix X11
  ];
  executableHaskellDepends = [ base ];
  testHaskellDepends = [
    base containers QuickCheck quickcheck-classes X11
  ];
  postInstall = ''
    install -D man/xmonad.1 ''${!outputDoc}/share/man/man1/xmonad.1
    install -D man/xmonad.hs ''${!outputDoc}/share/doc/$name/sample-xmonad.hs
  '';
  homepage = "http://xmonad.org";
  description = "A tiling window manager";
  license = lib.licenses.bsd3;
}
