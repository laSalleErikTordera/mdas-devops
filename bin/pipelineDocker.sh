#!/bin/bash

set -e

docker network create votingappNetwork || true

build()
{
    docker build -t lasalleeriktordera/votingapp:0.1 ./src/votingapp
    docker run --network votingappNetwork --name "votingapp" -p 8080:8080 -v $(pwd)/build/votingapp:/app -w /app -d ubuntu ./votingapp
}


cleanUp(){
    docker rm -f votingapp
}


cleanUp || true
GOOS=linux build

docker build \
    -t etordera/votingapp-test:0.0 \
    ./votingapp-test

docker run --rm --network votingappNetwork -e VOTINGAPP_HOST="votingapp:8080" etordera/votingapp-test:0.0