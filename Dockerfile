FROM sonarqube:10.7-community
ADD --chmod=550 https://github.com/C4tWithShell/community-rust/releases/download/v0.2.5/community-rust-plugin-0.2.5.jar /opt/sonarqube/extensions/plugins

# docker run --name sonarqube-custom -p 9000:9000 sonarqube:10.6-community
