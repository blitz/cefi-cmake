{rustPlatform, fetchFromGitHub, lib }:

rustPlatform.buildRustPackage rec {
  pname = "uefi";
  version = "v0.3.2";

  src = fetchFromGitHub {
    owner = "Richard-W";
    repo = "uefi-run";
    rev = "${version}";
    sha256 = "0rh0xfxv45pnadp8yf1fsi9b28lk5pbwjh0an53hklfdk8673h3g";
  };

  cargoSha256 = "1847hc8pzc525ycdvfdydqv54d745jzfniz4lfk08zh38k41j9b2";

  meta = with lib; {
    description = "Run UEFI applications directly with Qemu";
    homepage = https://github.com/Richard-W/uefi-run;
    license = licenses.mit;
    platforms = platforms.all;
  };
}
