{ nixpkgs ? import <nixpkgs> , pkgs ? nixpkgs {} }:
with pkgs;
mkShell {
  buildInputs = [
    cargo-tarpaulin
    sonar-scanner-cli
    libiconv-darwin
  ];
  shellHook = ''
    export RUSTFLAGS="-Aclippy::missing_safety_doc"
    alias sonars="cargo tarpaulin --skip-clean --no-fail-fast --target-dir=target/coverage --output-dir target --out Lcov ; \
    cargo clippy --message-format=json > target/clippy.json"
  '';
}
