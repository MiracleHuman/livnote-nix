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

  # nativeBuildInputs are tools executed at build-time
  nativeBuildInputs = [
    dpkg # Much cleaner for extracting .deb than ar + tar
    autoPatchelfHook # Automatically fixes missing libraries!
    wrapGAppsHook3 # Wraps the binary to set up GTK schemas
  ];

  # buildInputs are the libraries your app links against at runtime
  buildInputs = [
    gtk3
    webkitgtk_4_1
  ];

  unpackPhase = ''
    # Cleanly unpacks the deb directly into the build directory
    dpkg-deb -x $src .
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out

    # Copy extracted contents into the Nix store output
    cp -r usr/bin $out/bin
    cp -r usr/share $out/share

    # Fix absolute paths in the .desktop file
    substituteInPlace $out/share/applications/osvauld.desktop \
      --replace-fail 'Exec=livnote' "Exec=$out/bin/livnote"

    runHook postInstall
  '';

  # Note: autoPatchelfHook runs automatically in the fixupPhase,
  # so you don't need a custom preFixup or patchelf commands!
}
