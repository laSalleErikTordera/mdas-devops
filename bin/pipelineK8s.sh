#!/bin/bash

set -e
docker-compose rm -f || true
docker-compose up --build -d && \
docker-compose run --rm mytest && \
docker-compose push && \
echo "GREEN" || echo "RED"

#deploy
kubectl apply -f votingapp.yaml


kubectl run mytest \
	--generator=run-pod/v1 \
	--image=lasalleeriktordera/votingapp-test \
	--env VOTINGAPP_HOST=myvotingapp.votingapp \
	--rm --attach --restart=Never