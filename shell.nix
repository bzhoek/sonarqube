{ nixpkgs ? import <nixpkgs>
, pkgs ? nixpkgs {}
}:
let
  libsass = pkgs.libsass;
  postgresql = pkgs.postgresql_12;
in pkgs.mkShell {
  buildInputs = [
    pkgs.cargo-tarpaulin
    pkgs.sonar-scanner-cli
    pkgs.libiconv-darwin
  ];
}
