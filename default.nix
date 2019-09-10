{ nixpkgs ? <nixpkgs>

# This would be pretty cool, but it doesn't work (yet?).
#, pkgs ? import <nixpkgs> { crossSystem = { config = "x86_64-unknown-windows-msvc"; };}
, pkgs ? import <nixpkgs> {}
, stdenv ? pkgs.clangStdenv }:

rec {
  cefi = pkgs.callPackage ./nix/c-efi.nix { };

  cefi-cmake = stdenv.mkDerivation {
    pname = "cefi-cmake";
    version = "1.0.0";

    src = ./src;
    static = true;

    hardeningDisable = [ "all" ];
    nativeBuildInputs = [ pkgs.cmake pkgs.pkg-config pkgs.lld ];
    buildInputs = [ cefi ];
  };

  uefi-run = pkgs.callPackage ./nix/uefi-run.nix { };

  ovmf = pkgs.OVMF.fd;
}


