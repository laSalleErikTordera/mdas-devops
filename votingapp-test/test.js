var http = require("http");

var URL = "myproxy";
function setUp()
{
    console.log("Starting Pipeline Setup....");
    console.log("Finished Pipeline Setup....");
}

function test()
{
    var expectedWinner = "dev";

	console.log("Starting testing....");
	
	var opt	= {
        host: URL,
        path: '/vote',
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        }
    }

    var data = '{"topics": ["dev", "ops"]}'

    var req = http.request(opt, function (res) {
        var responseString = "";
    
        res.on("data", function (data) {
        });
        res.on("end", function () {
        });

        req.on("error", function(data){
            throw "Error thrown";
        });
    });
    
    req.write(data);
    req.end();

    opt	= {
        host: URL,
        path: '/vote',
        method: "PUT",
        headers: {
            "Content-Type": "application/json"
        }
    }

    data = '{"topic": "dev"}'

    req = http.request(opt, function (res) {
        var responseString = "";
    
        res.on("data", function (data) {
        });
        res.on("end", function () {
        });

        req.on("error", function(data){
            throw "Error thrown";
        });
    });
    
    req.write(data);
    req.end();

    opt	= {
        host: URL,
        path: '/vote',
        method: "DELETE",
        headers: {
            "Content-Type": "application/json"
        }
    }

    var responseString = "";
    req = http.request(opt, function (res) {
        
        res.on("data", function (data) {
            responseString += data;
            // save all the data from response
        });
        res.on("end", function () {
            if(JSON.parse(responseString).winner == expectedWinner)
            {
                console.log("TEST PASSED")
            }
            else
            {
                throw "Not expected winner";
            }
            // print to console when response ends
        });

        req.on("error", function(data){
            throw "Error thrown";
        });
    });
    
    req.write("");
    req.end();

    console.log("Finished testing....");
/* 
    if r.json()['winner'] == expectedWinner:
        return True

    raise(Exception("Got not a valid winner")) */
}    

function cleanUp()
{
    console.log("Starting pipeline clean up....")
    console.log("Finished pipeline clean up....")
}

setUp()
test()
cleanUp()
