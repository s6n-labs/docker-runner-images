FROM ubuntu:jammy-20230522 AS minimal

ARG APT_UBUNTU_MIRROR="http://ports.ubuntu.com/ubuntu-ports/"

RUN apt-get -y update && apt-get -y install ca-certificates
RUN sed -i "s http://ports.ubuntu.com/ubuntu-ports/ ${APT_UBUNTU_MIRROR} g" /etc/apt/sources.list

# Minimal Dependencies
RUN apt-get -y update && apt-get -yq install curl git sudo
RUN sed -i 's/%sudo	ALL=(ALL:ALL) ALL/%sudo	ALL=NOPASSWD: ALL/' /etc/sudoers
RUN useradd -m -U -G sudo runner

RUN mkdir -p /actions-runner && chown -R runner:runner /actions-runner
WORKDIR /actions-runner
USER runner

COPY ./scripts /tmp/scripts
RUN /tmp/scripts/install-actions-runner.sh && \
    sudo cp /tmp/scripts/docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

# ---

FROM minimal AS standard

USER root

# PPA repositories
RUN apt-get -y update && apt-get -y install software-properties-common && \
    add-apt-repository ppa:longsleep/golang-backports && \
    add-apt-repository ppa:ondrej/php

# GPG keys
RUN mkdir -p /etc/apt/keyrings && \
    curl -sSL https://packages.adoptium.net/artifactory/api/gpg/key/public > /etc/apt/keyrings/adoptium.asc

# APT repositories
RUN echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" > /etc/apt/sources.list.d/adoptium.list
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

# APT packages
RUN apt-get -y update && \
    DEBIAN_FRONTEND="noninteractive" apt-get -y install \
        autoconf automake build-essential cmake jq wget \
        golang-go nodejs php8.2-fpm \
        python3 python3-pip python3-venv

# .NET
RUN wget https://dot.net/v1/dotnet-install.sh -O /tmp/dotnet-install.sh && \
    chmod +x /tmp/dotnet-install.sh && \
    /tmp/dotnet-install.sh --version latest && \
    rm -f /tmp/dotnet-install.sh

# Node.js
RUN npm install -g npm pnpm && \
    corepack prepare yarn@stable --activate

# Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > /tmp/rustup.sh && \
    chmod +x /tmp/rustup.sh && \
    /tmp/rustup.sh -y && \
    rm -f /tmp/rustup.sh

USER runner

# ---

FROM standard AS dind

USER root

# GPG keys
RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg

# APT repositories
RUN echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null

# APT packages
RUN apt-get -y update && \
    apt-get -y install \
        init systemd \
        docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

COPY ./systemd/enable-docker-access.service /etc/systemd/system/enable-docker-access.service
RUN ln -s /etc/systemd/system/enable-docker-access.service \
    /etc/systemd/system/multi-user.target.wants/enable-docker-access.service

COPY ./systemd/github-actions-runner.service /etc/systemd/system/github-actions-runner.service
RUN ln -s /etc/systemd/system/github-actions-runner.service \
    /etc/systemd/system/multi-user.target.wants/github-actions-runner.service

COPY ./scripts/enable-docker-access.sh /enable-docker-access.sh
COPY ./scripts/docker-entrypoint-dind.sh /docker-entrypoint.sh
