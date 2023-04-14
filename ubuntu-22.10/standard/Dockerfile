FROM ghcr.io/s6n-jp/docker-runner-images:ubuntu-22.10-minimal

RUN sudo apt-get -y update && sudo -E apt-get -y install autoconf automake build-essential cmake jq software-properties-common wget

# .NET
RUN wget https://dot.net/v1/dotnet-install.sh -O /tmp/dotnet-install.sh && \
    chmod +x /tmp/dotnet-install.sh && \
    /tmp/dotnet-install.sh --version latest && \
    rm -f /tmp/dotnet-install.sh

# Go
RUN sudo add-apt-repository ppa:longsleep/golang-backports && \
    sudo apt-get update && sudo -E apt-get install -y golang-go

# Java
RUN sudo mkdir -p /etc/apt/keyrings && \
    wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo tee /etc/apt/keyrings/adoptium.asc && \
    echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list && \
    sudo apt-get -y update && sudo -E apt-get -y install temurin-17-jdk

# Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - && \
    sudo -E apt-get -y install -y nodejs && \
    sudo npm install -g npm pnpm && \
    corepack prepare yarn@stable --activate

# PHP
RUN sudo add-apt-repository ppa:ondrej/php && \
    sudo apt-get -y update && sudo -E apt-get -y install php8.2-fpm

# Python
RUN sudo apt-get -y install python3 python3-pip python3-venv

# Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > /tmp/rustup.sh && \
    chmod +x /tmp/rustup.sh && \
    /tmp/rustup.sh -y && \
    rm -f /tmp/rustup.sh
