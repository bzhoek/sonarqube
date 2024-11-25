# SonarQube with Rust plugin

Docker image with the [community-rust](https://github.com/C4tWithShell/community-rust) plugin installed.

Run the scanner from a Nix shell:

```shell
cargo install cargo-tarpaulin
RUN_MODE=local cargo tarpaulin --ignore-tests --no-fail-fast --all-features --release --output-dir target --out Lcov

cargo clippy --message-format=json &> target/clippy.json
RUSTFLAGS="-Aclippy::missing_safety_doc" cargo clippy --message-format=json > target/clippy.json

nix-shell

sonar-scanner -Dsonar.projectKey=happer -Dsonar.sources=. -Dsonar.host.url=http://localhost:9000 -Dsonar.token=sqp_...
```
