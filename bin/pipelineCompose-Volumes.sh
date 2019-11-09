#!/bin/bash

set -e

docker-compose -f docker-compose-volumes.yml rm -f || true
docker-compose -f docker-compose-volumes.yml up --build -d&& \
docker-compose -f docker-compose-volumes.yml run --rm mytest && \
#docker-compose push && \
echo "GREEN" || echo "RED"
