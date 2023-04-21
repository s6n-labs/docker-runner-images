FROM ghcr.io/s6n-jp/docker-runner-images:ubuntu-22.10-minimal

USER root

# PPA repositories
RUN apt-get -y update && apt-get -y install software-properties-common
    # PHP: ondrej/php does not support kinetic yet
    # add-apt-repository ppa:ondrej/php

# GPG keys
RUN mkdir -p /etc/apt/keyrings && \
    curl -sSL https://packages.adoptium.net/artifactory/api/gpg/key/public > /etc/apt/keyrings/adoptium.asc

# APT repositories
RUN echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" > /etc/apt/sources.list.d/adoptium.list
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

# APT packages
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y update && \
    apt-get -y install \
        autoconf automake build-essential cmake jq wget \
        nodejs temurin-17-jdk \
        python3 python3-pip python3-venv
        # PHP: ondrej/php does not support kinetic yet
        # php8.2-fpm

# Go
RUN curl -LO https://get.golang.org/$(uname)/go_installer && chmod +x go_installer && ./go_installer && rm go_installer

# .NET
RUN wget https://dot.net/v1/dotnet-install.sh -O /tmp/dotnet-install.sh && \
    chmod +x /tmp/dotnet-install.sh && \
    /tmp/dotnet-install.sh --version latest && \
    rm -f /tmp/dotnet-install.sh

# Node.js
RUN npm install -g npm pnpm && \
    corepack prepare yarn@stable --activate

# Python
RUN --mount=type=cache,target=/var/cache/apt \
    sudo apt-get -y install python3 python3-pip python3-venv

# Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > /tmp/rustup.sh && \
    chmod +x /tmp/rustup.sh && \
    /tmp/rustup.sh -y && \
    rm -f /tmp/rustup.sh

USER runner
