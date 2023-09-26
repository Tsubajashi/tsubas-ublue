#!/usr/bin/env bash
set -oue pipefail

# Installing the Bore EEVDF RT Kernel
echo "Installing Custom Kernel (Bore)"
rpm-ostree override remove kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra --install kernel-cachyos-bore-eevdf-rt