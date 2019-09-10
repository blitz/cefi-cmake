#!/bin/sh

set -eux

nix-build
./result-3/bin/uefi-run ./result-2/bin/cmake-cefi -b ./result-3-fd/FV/OVMF.fd
