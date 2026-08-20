#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export ELEMENTS_PATH="${ROOT}/elements"
export DIB_BLOCK_DEVICE_CONFIG="file://${ROOT}/block-devices/xfs.yaml"

cd "${ROOT}"

.venv/bin/diskimage-builder images/$1.yaml
