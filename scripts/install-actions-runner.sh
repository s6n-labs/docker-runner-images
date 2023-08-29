#!/usr/bin/env sh

set -eux

ACTIONS_RUNNER_VERSION="2.308.0"
ARCH="$(uname -m)"

if [ $ARCH = "aarch64" ]; then
    ARCH_SHORT="arm64"
    ARCHIVE_CHECKSUM="e39b3137fcaad3262e1def26d3e42cdd810c831a3c836deeb560a2266338b503"
elif [ $ARCH = "x86_64" ]; then
    ARCH_SHORT="x64"
    ARCHIVE_CHECKSUM="9f994158d49c5af39f57a65bf1438cbae4968aec1e4fec132dd7992ad57c74fa"
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
