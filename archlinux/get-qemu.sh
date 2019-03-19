#!/bin/bash

export QEMU_VERSION=3.1.0-2

for TARGET_ARCH in aarch64 arm x86_64; do
  wget -N https://github.com/multiarch/qemu-user-static/releases/download/v${QEMU_VERSION}/x86_64_qemu-${TARGET_ARCH}-static.tar.gz
  tar -xvf x86_64_qemu-${TARGET_ARCH}-static.tar.gz
  rm x86_64_qemu-${TARGET_ARCH}-static.tar.gz
done
