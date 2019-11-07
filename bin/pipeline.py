from retry import retry
import requests
import json 

URL = "http://localhost:8080/vote"


def setUp():

    print("Starting Pipeline Setup....")
    print("Finished Pipeline Setup....")


@retry(tries=3, delay=5)
def test():

    expectedWinner = "dev"
    print("Starting testing....")

    r = requests.post(
        url=URL,
        data={'topics': ['dev', 'ops']},
        headers={'Accept': 'Content-type: application/json'}
    )

    r = requests.put(
        url=URL,
        json={'topic':'dev'},
        headers={'Accept': 'Content-type: application/json'}
    )

    r = requests.delete(
        url=URL,
        headers={'Accept': 'Content-type: application/json'}
    )
    
    print("Finished testing....")

    if r.json()['winner'] == expectedWinner:
        return True

    raise(Exception("Got not a valid winner"))
    


def cleanUp():

    print("Starting pipeline clean up....")
    print("Finished pipeline clean up....")


setUp()
test()
cleanUp()
