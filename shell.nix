{ nixpkgs ? import <nixpkgs> , pkgs ? nixpkgs {} }:
with pkgs;
mkShell {
  buildInputs = [
    cargo-tarpaulin
    sonar-scanner-cli
    libiconv-darwin
  ];
  shellHook = ''
    alias sonars="RUSTFLAGS=-Aclippy::missing_safety_doc \
      cargo clippy --message-format=json > target/clippy.json; \
      cargo tarpaulin --skip-clean --no-fail-fast --output-dir target --out Lcov"
  '';
}
