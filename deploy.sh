#!/usr/bin/env bash

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${ROOT}"

while read id; do
    .venv/bin/openstack image delete $id
done <<< $(.venv/bin/openstack image list --public -fvalue -cid -cname | grep "${1}$" | cut -f1 -d' ')

.venv/bin/openstack image create --public --disk-format qcow2 --file "${1}".qcow2 "${1}"

rm "./$1.qcow2"
