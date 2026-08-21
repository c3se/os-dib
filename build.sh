#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export ELEMENTS_PATH="${ROOT}/elements"
export DIB_BLOCK_DEVICE_CONFIG="file://${ROOT}/block-devices/xfs.yaml"

cd "${ROOT}"

if [[ "${1:-}" == "fedora44" ]]; then
    FEDORA_RELEASE=44
    ARCH="${ARCH:-x86_64}"

    export DIB_RELEASE="${FEDORA_RELEASE}"
    export DIB_CLOUD_IMAGES="https://download.fedoraproject.org/pub/fedora/linux/releases/${FEDORA_RELEASE}/Cloud/${ARCH}/images"

    BASE_IMAGE_FILE="$(
        curl -fsSL "${DIB_CLOUD_IMAGES}/" |
        grep -oE "Fedora-Cloud-Base-Generic-${FEDORA_RELEASE}-[0-9.]+\.${ARCH}\.qcow2" |
        sort -Vu |
        tail -1
    )"

    if [[ -z "${BASE_IMAGE_FILE}" ]]; then
        echo "Unable to discover Fedora ${FEDORA_RELEASE} cloud image" >&2
        exit 1
    fi

    export BASE_IMAGE_FILE
    export SUBRELEASE_REGEXP="(?<=Fedora-Cloud-Base-Generic-${FEDORA_RELEASE}-).*?(?=\\.${ARCH}\\.qcow2)"

    echo "Fedora source image: ${DIB_CLOUD_IMAGES}/${BASE_IMAGE_FILE}"
fi


.venv/bin/diskimage-builder images/$1.yaml
