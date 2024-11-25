{ nixpkgs ? import <nixpkgs>
, pkgs ? nixpkgs {}
}:
let
  libsass = pkgs.libsass;
  postgresql = pkgs.postgresql_12;
in pkgs.mkShell {
  buildInputs = [
    pkgs.sonar-scanner-cli
  ];
}
