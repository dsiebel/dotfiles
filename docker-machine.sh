#!/usr/bin/env bash
readonly machine_name="${1?Argument 1 (machine name) is required}"

echo "MACHINE NAME: ${machine_name}"

# set up a better docker-machine
if docker-machine status "${machine_name}"; then
  docker-machine kill "${machine_name}"
	docker-machine rm -y "${machine_name}"
fi

docker-machine create --driver "virtualbox" \
 --virtualbox-cpu-count "-1" \
 --virtualbox-disk-size "40000" \
 --virtualbox-memory "2048" \
 --virtualbox-no-share \
 --virtualbox-host-dns-resolver \
 --engine-opt max-concurrent-downloads=8 \
 "${machine_name}"
