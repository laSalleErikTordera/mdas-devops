#!/bin/bash

set -e
# CI/CD Pipeline for the project votingapp

# Clean-Up
rm -rf build

# Dependencies Install
go get github.com/gorilla/websocket
go get github.com/labstack/echo

mkdir build
mkdir build/votingapp

# Go Build
go build -o ./build/votingapp/votingapp ./src/votingapp

# Copy static files
cp -r src/votingapp/ui build/votingapp

pushd build/votingapp/
./votingapp &
popd

# Testing
curl --url "localhost:8080/vote" \
    --request POST \
    --data '{"topics":["dev", "ops"]}' \
    --header "Content-type: application/json"

curl --url "localhost:8080/vote" \
    --request PUT \
    --data '{"topic": "dev"}'  \
    --header "Content-type: application/json"

winner=$(curl --url "localhost:8080/vote" --request DELETE --header "Content-type: application/json" | jq -r '.winner')


pkill votingapp

echo "Winner is: "$winner
expectedWinner="dev"

if [ "$expectedWinner"=="$winner" ]; then
    echo "TEST_PASSED"
    exit 0
else
    echo "TEST FAILED"
    exit 1
fi
