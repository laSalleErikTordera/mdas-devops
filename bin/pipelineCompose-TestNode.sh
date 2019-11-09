#!/bin/bash

set -e
docker-compose -f docker-compose-testnode.yml rm -f || true
docker-compose -f docker-compose-testnode.yml up --build -d && \
docker-compose -f docker-compose-testnode.yml run --rm mytest && \
#docker-compose push && \
echo "GREEN" || echo "RED"
