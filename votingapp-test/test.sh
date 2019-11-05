#!/bin/bash

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
 
retry test