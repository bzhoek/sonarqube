{ nixpkgs ? import <nixpkgs> , pkgs ? nixpkgs {} }:
with pkgs;
mkShell {
  buildInputs = [
    cargo-tarpaulin
    sonar-scanner-cli
    libiconv-darwin
  ];
}
