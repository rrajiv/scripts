var http = require("http");
var url = require("url");
fs =  require("fs");

// define the callback function that dumps out the cloudmonitor response
// only want to dump headers for /cloudmonitor
// rest get a standard response
var dumpbody = function(req, res)
{
    // capture incoming details
    var incominguri = url.parse(req.url).pathname;
    var incomingmethod = req.method;
    var timestamp = new Date( Date.now());
    
    // only look for this pattern and POST requests
    if (incominguri == "/cloudmonitor" && incomingmethod == "POST")
    {
        // capture incoming headers        
        var incomingheaders = JSON.stringify(req.headers);

        console.log("Requet URI =  " + incominguri);
        console.log("Request Headers = " + incomingheaders);
        console.log("Request Time = " + timestamp);
        console.log("POST body below = ");

        postbody = "";
        res.writeHead(200);
        req.on('data', function (data) {
            postbody += data;
        });

        req.on('end', function () {
            // remove certain characters like slash
            var result = postbody.replace(/\\/g, "");
            console.log(JSON.parse(result));
            console.log("----");
        });
        
    } // end if

    // write the response to user
    res.end();
    
}; // end dumpheader

// create a server and listener
var server = http.createServer(dumpbody);
server.listen(5001);