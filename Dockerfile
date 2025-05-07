FROM sonarqube:24.12.0.100206-community
ADD --chmod=550 https://github.com/C4tWithShell/community-rust/releases/download/v0.2.6/community-rust-plugin-0.2.6.jar /opt/sonarqube/extensions/plugins
