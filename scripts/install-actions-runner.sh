#!/usr/bin/env sh

ARCH="$(uname -m)"

if [ $ARCH = "aarch64" ]; then
    ARCH_SHORT="arm64"
    ARCHIVE_CHECKSUM="53f137fb4c00ac9906cbdf4b7c5c14e2e9555a2843d5c0171f6368207472464d"
elif [ $ARCH = "x86_64" ]; then
    ARCH_SHORT="x64"
    ARCHIVE_CHECKSUM="e4a9fb7269c1a156eb5d5369232d0cd62e06bec2fd2b321600e85ac914a9cc73"
else
    echo "This platform is not supported."
    exit 1
fi

curl -L -o actions-runner.tar.gz \
    "https://github.com/actions/runner/releases/download/v${ACTIONS_RUNNER_VERSION}/actions-runner-linux-${ARCH_SHORT}-${ACTIONS_RUNNER_VERSION}.tar.gz"

echo "${ARCHIVE_CHECKSUM}  actions-runner.tar.gz" | shasum -a 256 -c

tar xzf ./actions-runner.tar.gz
sudo ./bin/installdependencies.sh
