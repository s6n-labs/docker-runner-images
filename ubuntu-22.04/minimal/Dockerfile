FROM ubuntu:jammy-20230522

ARG APT_UBUNTU_MIRROR="http://ports.ubuntu.com/ubuntu-ports/"
ARG ACTIONS_RUNNER_VERSION="2.304.0"

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
