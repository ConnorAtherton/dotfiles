#!/bin/bash

docker run --restart always -d \
  -p 127.0.0.1:5000:5000 \
  --name registry \
  -v /mnt/persistent_docker_registry_storage:/var/lib/registry \
  registry:2
