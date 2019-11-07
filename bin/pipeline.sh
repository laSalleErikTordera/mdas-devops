#!/bin/bash

#Set error hanbdling to stop if any order fails
set -e
# CI/CD Pipeline for the project votingapp

#Clean Up
cleanUp(){
    pkill votingapp || true
    rm -rf build || true
}

deps(){
    go get "github.com/gorilla/websocket"
	go get "github.com/labstack/echo"
}

build()
{
    mkdir build
    mkdir build/votingapp

    go build -o build/votingapp/votingapp ./src/votingapp
    cp -r src/votingapp/ui build/votingapp

    pushd build/votingapp
    ./votingapp &
    popd
}

retry(){
    n=0
    interval=5
    retries=3
    $@ && return 0
    until [ $n -ge $retries ]
    do
        n=$[$n+1]
        echo "Retrying...$n of $retries, wait for $interval seconds"
        sleep $interval
        $@ && return 0
    done

    return 1
}

test()
{
    votingurl="localhost:8080/vote"

    curl --url $votingurl \
    --request  POST \
    --data '{"topics":["dev", "ops"]}' \
    --header "Content-type: application/json"

    curl --url $votingurl \
    --request PUT \
    --data '{"topic": "dev"}' \
    --header "Content-type: application/json"

    winner=$(curl --url $votingurl --request DELETE --header "Content-type: application/json" | jq -r '.winner')

    echo "Winner is: "$winner
    expectedWinner="dev"

    if [ "$expectedWinner" == "$winner" ]; then
        echo "TEST_PASSED"
        return 0
    else
        echo "TEST_FAILED"
        return 1
    fi
}

deps
cleanUp
build
#retry test
python3 ./bin/pipeline.py