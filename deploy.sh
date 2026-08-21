#!/usr/bin/env bash

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${ROOT}"

IMAGE_ID=$(openstack image show "$1" -fvalue -cid 2>/dev/null || echo "")

if [[ $IMAGE_ID != "" ]]; then
  .venv/bin/openstack image delete "$IMAGE_ID"
fi

.venv/bin/openstack image create --public --disk-format qcow2 --file "${1}".qcow2 "$1"

rm "$1.qcow2"
