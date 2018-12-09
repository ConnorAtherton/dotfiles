#!/bin/bash

docker run --restart always -d \
  --name gateway \
  -v /var/stacks/htpasswd:/etc/nginx/htpasswd:ro \
  -v /var/stacks/nginx.conf:/etc/nginx/nginx.conf:ro \
  -v /var/stacks/infra.connoratherton.com:/etc/nginx/conf.d/infra.connoratherton.com:ro \
  -v /etc/letsencrypt/:/etc/ssl:ro \
  --network="host" \
  nginx:mainline-alpine
