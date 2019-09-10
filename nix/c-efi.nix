{ stdenv, meson, ninja, writeText }:

let
  pcTemplate = ./c-efi.pc;
in
stdenv.mkDerivation rec {
  pname = "c-efi";
  version = "";

  src = builtins.fetchGit {
    url = "https://github.com/c-util/c-efi.git";
    rev = "8b3b679fa7e0789c0dd9c9e93a2a6c5c1fa99f15";
    ref = "master";
  };

  hardeningDisable = [ "all" ];
  nativeBuildInputs = [ ];
  buildInputs = [ ];

  installPhase = ''
    mkdir -p $out/include
    cp src/*.h $out/include/

    mkdir -p $out/share/pkgconfig/
    sed "s,@OUT@,$out," ${pcTemplate} > $out/share/pkgconfig/c-efi.pc
  '';
}
