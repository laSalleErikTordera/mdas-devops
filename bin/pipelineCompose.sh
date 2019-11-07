#!/bin/bash

set -e
docker-compose rm -f || true
docker-compose up --build -d && \
docker-compose run --rm mytest && \
#docker-compose push && \
echo "GREEN" || echo "RED"
