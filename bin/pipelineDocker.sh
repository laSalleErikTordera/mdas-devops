#!/bin/bash

set -e

docker network create votingappNetwork || true

build()
{
    docker run --name myredis --network votingappNetwork -d redis || true
    docker build -t votingapp ./src/votingapp
    docker run --network votingappNetwork --name "votingapp" -e REDIS="myredis:6379" -p 8080:8080 -v $(pwd)/build/votingapp:/app -w /app -d lasalleeriktordera/votingapp:0.1
}


cleanUp(){
    pkill votingapp
    docker rm -f votingapp
    docker rm -f myredis
}


cleanUp || true
GOOS=linux build

docker build \
    -t etordera/votingapp-test:0.0 \
    ./votingapp-test

docker run --rm --network votingappNetwork -e VOTINGAPP_HOST="votingapp:8080" etordera/votingapp-test:0.0