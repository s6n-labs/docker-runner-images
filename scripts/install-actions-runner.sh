#!/usr/bin/env sh

set -eux

ARCH="$(uname -m)"

if [ $ARCH = "aarch64" ]; then
    ARCH_SHORT="arm64"
    ARCHIVE_CHECKSUM="34c49bd0e294abce6e4a073627ed60dc2f31eee970c13d389b704697724b31c6"
elif [ $ARCH = "x86_64" ]; then
    ARCH_SHORT="x64"
    ARCHIVE_CHECKSUM="292e8770bdeafca135c2c06cd5426f9dda49a775568f45fcc25cc2b576afc12f"
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
