#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${ROOT}"

# Re-use same ID
IMAGE_ID=$(openstack image show $1 -fvalue -cid)

.venv/bin/openstack image delete $IMAGE_ID 2>/dev/null || echo 1

.venv/bin/openstack image create --id $IMAGE_ID --public --disk-format qcow2 --file $1.qcow2 $1
