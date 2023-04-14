FROM ubuntu:kinetic-20230308

ARG ACTIONS_RUNNER_VERSION="2.303.0"

ENV DEBIAN_FRONTEND="noninteractive"

# Minimal Dependencies
RUN --mount=type=cache,target=/var/cache/apt apt-get -y update && apt-get -yq install curl git sudo
RUN sed -i 's/%sudo	ALL=(ALL:ALL) ALL/%sudo	ALL=NOPASSWD: ALL/' /etc/sudoers
RUN useradd -m -U -G sudo runner

RUN mkdir -p /actions-runner && chown -R runner:runner /actions-runner
WORKDIR /actions-runner
USER runner

COPY ./scripts /tmp/scripts
RUN /tmp/scripts/install-actions-runner.sh && \
    sudo cp /tmp/scripts/docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
