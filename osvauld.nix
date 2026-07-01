{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  autoPatchelfHook,
  wrapGAppsHook3,
  gtk3,
  webkitgtk_4_1,
}:

stdenv.mkDerivation rec {
  pname = "livnote";
  version = "0.1.0";

  src = fetchurl {
    url = "https://github.com/osvauld/osvauld/releases/download/alpha/osvauld_0.1.0_amd64.deb";
    sha256 = "sha256-PDuI3Gl1nVrEtKM/di2E2ms3sLvVbFm/IjDWLCXHld8=";
  };

  
  nativeBuildInputs = [
    dpkg 
    autoPatchelfHook 
    wrapGAppsHook3
  ];

  
  buildInputs = [
    gtk3
    webkitgtk_4_1
  ];

  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out

    cp -r usr/bin $out/bin
    cp -r usr/share $out/share

    substituteInPlace $out/share/applications/osvauld.desktop \
      --replace-fail 'Exec=livnote' "Exec=$out/bin/livnote"

    runHook postInstall
  '';

}
