#!/usr/bin/env sh

set -eux

ACTIONS_RUNNER_VERSION="2.311.0"
ARCH="$(uname -m)"

if [ $ARCH = "aarch64" ]; then
    ARCH_SHORT="arm64"
    ARCHIVE_CHECKSUM="5d13b77e0aa5306b6c03e234ad1da4d9c6aa7831d26fd7e37a3656e77153611e"
elif [ $ARCH = "x86_64" ]; then
    ARCH_SHORT="x64"
    ARCHIVE_CHECKSUM="29fc8cf2dab4c195bb147384e7e2c94cfd4d4022c793b346a6175435265aa278"
else
    echo "This platform is not supported."
    exit 1
fi

curl -L -o actions-runner.tar.gz \
    "https://github.com/actions/runner/releases/download/v${ACTIONS_RUNNER_VERSION}/actions-runner-linux-${ARCH_SHORT}-${ACTIONS_RUNNER_VERSION}.tar.gz"

echo "${ARCHIVE_CHECKSUM}  actions-runner.tar.gz" | shasum -a 256 -c

tar xzf ./actions-runner.tar.gz
rm -f ./actions-runner.tar.gz

sudo ./bin/installdependencies.sh
