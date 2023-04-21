FROM ghcr.io/s6n-jp/docker-runner-images:ubuntu-22.04-standard

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
