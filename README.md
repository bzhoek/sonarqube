# SonarQube with Rust plugin

Docker image with the [community-rust](https://github.com/C4tWithShell/community-rust) plugin installed.

Run the scanner from a Nix shell:

```shell
docker compose up

cargo install cargo-tarpaulin
cargo tarpaulin --skip-clean --no-fail-fast --output-dir target --out Lcov

cargo clippy --message-format=json &> target/clippy.json
RUSTFLAGS="-Aclippy::missing_safety_doc" cargo clippy --message-format=json > target/clippy.json

nix-shell
export SONAR_TOKEN=sqa_

sonar-project.properties:
sonar.host.url=http://localhost:9000
sonar.projectKey=gymrs
sonar.sources=src
sonar.tests=tests
sonar.rust.clippy.reportPaths=target/clippy.json
sonar.rust.lcov.reportPaths=target/lcov.info

sonar-scanner
sonar-scanner -Dsonar.projectKey=gymrs -Dsonar.host.url=http://localhost:9000 -Dsonar.rust.clippy.reportPaths=target/clippy.json -Dsonar.rust.lcov.reportPaths=target/lcov.info -Dsonar.sources=src -Dsonar.tests=tests
```
