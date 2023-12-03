# GitHub Self-Hosted Runner images for running on Docker

## Usage

```shell
docker run ghcr.io/s6n-labs/docker-runner-images:ubuntu-22.04-standard \
    --url https://github.com/<your_organisation> --token <your_token>
```


## OSes and Variants

### Ubuntu 22.04 (jammy)

#### Minimal

GitHub Actions Runner and their dependencies only


#### Standard

- C/C++ Build Tools
  - autoconf
  - automake
  - build-essential
  - cmake
- .NET SDK (stable)
- Go (stable)
- Temurin JDK v21
- Node.js v20
- PHP v8.3
- Python v3
- Rust (stable)
- Misc
  - jq
  - software-properties-common (for add-apt-repository)
  - wget


#### DinD

- systemd
- Docker
  - Docker Engine
  - Docker CLI
  - Docker Compose Plugin


### Ubuntu 23.04 (lunar)

#### Minimal

GitHub Actions Runner and their dependencies only


#### Standard

- C/C++ Build Tools
  - autoconf
  - automake
  - build-essential
  - cmake
- .NET SDK (stable)
- Go (stable)
- ~~Temurin JDK v21~~ (Official APT repository does not support lunar yet)
- Node.js v20
- ~~PHP v8.3~~ (ondrej/php does not support lunar yet)
- Python v3
- Rust (stable)
- Misc
  - jq
  - software-properties-common (for add-apt-repository)
  - wget


#### DinD

- systemd
- Docker
  - Docker Engine
  - Docker CLI
  - Docker Compose Plugin
