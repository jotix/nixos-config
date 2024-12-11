{ stdenv, cups, lib, glibc, fetchFromGitHub, gcc-unwrapped, autoPatchelfHook }:

stdenv.mkDerivation {

  name = "cups-hprtpos";
  version = "1.0";
  system = "x86_64-linux";

  src = fetchFromGitHub {
    owner = "jotix";
    repo = "hprtpos";
    rev = "main";
    sha256 = "sha256-bR+tvf3OubYQxq7yBLSyUyHYOkRTyBhA5TDRiM0arao=";
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
    install -d -m 777 $out/share/cups/model/hprtpos/
    install -m 644 ppd/*.ppd $out/share/cups/model/hprtpos/
    install -m 755 -D filter/x64/raster-esc $out/lib/cups/filter/raster-esc
  '';

  meta = with lib; {
    description = "CUPS filter for HPRT POS thermal printers";
    homepage = "https://github.com/jotix/hprtpos";
    platforms = platforms.linux;
    maintainers = with maintainers; [ jotix ];
    license = licenses.bsd2;
  };
  
}
