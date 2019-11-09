#!/bin/bash

set -e

docker-compose -f docker-compose-testpython.yml rm -f || true
docker-compose -f docker-compose-testpython.yml up --build -d&& \
docker-compose -f docker-compose-testpython.yml run --rm mytest && \
#docker-compose push && \
echo "GREEN" || echo "RED"
