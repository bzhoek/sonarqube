# SonarQube with Rust plugin

Docker image met [community-rust](https://github.com/C4tWithShell/community-rust) plugin en Nix shell met `sonar-scanner`.

## Setup

```sh
docker compose up
cargo install cargo-tarpaulin
```

In [#Upgrade] staat hoe je een nieuwere versie van SonarQube kunt installeren.

## Configuratie

In SonarQube een project maken met `Create Project`, `Local Project`. De `Project key` opslaan in `sonar-project.properties` in de root van het project:

```sh
sonar-project.properties:
sonar.host.url=http://localhost:9000
sonar.projectKey=gymrs
sonar.sources=src
sonar.tests=tests
community.rust.clippy.reportPaths=target/clippy.json
community.rust.lcov.reportPaths=target/lcov.info
```

Onder Administrator, My Account, Security een Global Analysis Token `sqa_*`aanmaken of die van `Sonarqube Docker` in `1Password` gebruiken.

## Analysis

Coverage klaarzetten in `target/lcov.info` en Clippy waarschuwingen in `target/clippy.json`, zodat de Scanner ze kan doorsturen.

```sh
cargo tarpaulin --skip-clean --no-fail-fast --output-dir target --out Lcov
cargo clippy --message-format=json &> target/clippy.json
RUSTFLAGS="-Aclippy::missing_safety_doc" cargo clippy --message-format=json > target/clippy.json
```

## Scanner

Start de Java `sonar-scanner` van `shell.nix` in folder waar `sonar-project.properties` staat om de SonarQube data bij te werken met coverage en lint uit de analyse stap hierboven.

```sh
nix-shell
export SONAR_TOKEN=sqa_

sonar-scanner # leest alles uit sonar-project.properties en token uit SONAR_TOKEN
sonar-scanner -Dsonar.projectKey=gymrs -Dsonar.host.url=http://localhost:9000 -Dsonar.rust.clippy.reportPaths=target/clippy.json -Dsonar.rust.lcov.reportPaths=target/lcov.info -Dsonar.sources=src -Dsonar.tests=tests
```

## Upgrade

De data wordt buiten Docker in `pgdata` bewaard. In [Dockerfile] de `FROM` aanpassen naar de nieuwe versie en een nieuwe `latest` tag maken:

```sh
docker rmi sonarqube-sonarqube:latest
docker compose up
```

Het kan zijn dat een database upgrade nodig is, ga dan naar http://localhost:9000/setup
