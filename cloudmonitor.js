var http = require("http");
var url = require("url");

// define the callback function that dumps out the cloudmonitor response
// only want to dump headers for /cloudmonitor
// rest get a standard response
var dumpbody = function(req, res)
{
    incominguri = url.parse(req.url).pathname;
    incomingmethod = req.method;

    // only look for this pattern and POST requests
    if (incominguri == "/cloudmonitor" && incomingmethod == "POST")
    {        
        postbody = "";
        res.writeHead(200);
        req.on('data', function (data) {
            postbody += data;
        });

        req.on('end', function () {

            // remove certain characters like slash
            var result = postbody.replace(/\\/g, "");
            console.log(JSON.parse(result));
            res.write(JSON.parse(result));
        });
        
    } // end if

    // write the response to user
    res.end();
    
}; // end dumpheader

// create a server and listener
var server = http.createServer(dumpbody);
server.listen(8081);
