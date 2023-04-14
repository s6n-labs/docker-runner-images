# GitHub Self-Hosted Runner images for running on Docker

## Usage

```shell
docker run ghcr.io/s6n-jp/docker-runner-images:ubuntu-22.04-standard \
    --url https://github.com/<your_organisation> --token <your_token>
```


## OSes and Variants

### Ubuntu 22.04

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
- Temurin JDK v17
- Node.js v18
- PHP v8.2
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
