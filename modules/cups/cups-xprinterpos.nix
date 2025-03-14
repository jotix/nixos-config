{
  stdenv,
  cups,
  lib,
  glibc,
  fetchFromGitHub,
  gcc-unwrapped,
  autoPatchelfHook,
}:

stdenv.mkDerivation {

  name = "cups-xprinterpos";
  version = "1.0";
  system = "x86_64-linux";

  src = fetchFromGitHub {
    owner = "jotix";
    repo = "xprinterpos";
    rev = "main";
    sha256 = "sha256-kKJhbwEIGGpmbxXbCZE054IWMMkMFhJoed40Jr5sZVQ=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    cups
    glibc
    gcc-unwrapped
  ];

  installPhase = ''
    install -d -m 777 $out/share/cups/model/xprinterpos/
    install -m 644 ppd/*.ppd $out/share/cups/model/xprinterpos/
    install -m 755 -D filter/x64/rastertosnailep-pos $out/lib/cups/filter/rastertosnailep-pos
  '';

  meta = with lib; {
    description = "CUPS filter for XPrinter POS thermal printers";
    homepage = "https://github.com/jotix/xprinterpos";
    platforms = platforms.linux;
    maintainers = with maintainers; [ jotix ];
    license = licenses.bsd2;
  };

}
