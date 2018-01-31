#!/usr/bin/env bash
MACHINE="${1:-default}"

echo "MACHINE: ${MACHINE}"

# set up a better docker-machine
if [[ "$(docker-machine status ${MACHINE})" == 0 ]]; then
  docker-machine kill "${MACHINE}" && docker-machine rm "${MACHINE}"
fi

docker-machine create --driver "virtualbox" \
 --virtualbox-cpu-count "-1" \
 --virtualbox-disk-size "40000" \
 --virtualbox-memory "4096" \
 --virtualbox-no-share \
 --virtualbox-host-dns-resolver \
 --engine-opt max-concurrent-downloads=8 \
 "${MACHINE}"
