FROM ghcr.io/s6n-jp/docker-runner-images:ubuntu-22.10-standard

USER root

RUN --mount=type=cache,target=/var/cache/apt \
    apt-get -y update && apt-get -y install ca-certificates curl gnupg init systemd

RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg

RUN echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN --mount=type=cache,target=/var/cache/apt \
    apt-get -y update && \
    apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

COPY ./systemd/enable-docker-access.service /etc/systemd/system/enable-docker-access.service
RUN ln -s /etc/systemd/system/enable-docker-access.service \
    /etc/systemd/system/multi-user.target.wants/enable-docker-access.service

COPY ./systemd/github-actions-runner.service /etc/systemd/system/github-actions-runner.service
RUN ln -s /etc/systemd/system/github-actions-runner.service \
    /etc/systemd/system/multi-user.target.wants/github-actions-runner.service

COPY ./scripts /tmp/scripts
RUN cp /tmp/scripts/enable-docker-access.sh /enable-docker-access.sh
RUN cp /tmp/scripts/docker-entrypoint-dind.sh /docker-entrypoint.sh
