FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
# Prevent Buildroot error when building as root

RUN apt-get update \
  && apt-get install -y \
  acpica-tools \
  android-tools-fastboot \
  autoconf \
  bc \
  bison \
  bzip2 \
  ccache \
  cmake \
  cpio \
  curl \
  device-tree-compiler \
  expect \
  file \
  flex \
  g++ \
  gdisk \
  gettext \
  git \
  gpg \
  libattr1-dev \
  libcap-ng-dev \
  libglib2.0-dev \
  libguestfs-tools \
  libpixman-1-dev \
  libslirp-dev \
  libssl-dev \
  lsb-release \
  make \
  ncat \
  ninja-build \
  pkg-config \
  python-is-python3 \
  python3 \
  python3-cryptography \
  python3-cryptography \
  python3-distutils \
  python3-pycryptodome \
  python3-pyelftools \
  rsync \
  sudo \
  unzip \
  uuid-dev \
  vim \
  xz-utils \
  wget \
  && apt-get autoremove

RUN curl -o /usr/local/bin/repo https://storage.googleapis.com/git-repo-downloads/repo \
  && chmod a+x /usr/local/bin/repo
