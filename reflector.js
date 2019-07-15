var http = require("http");
var url = require("url");

// define the callback function that hands the request + response
// only want to dump headers for /dumpheader
// rest get a standard response
var dumpheader = function(req, res)
{
    incominguri = url.parse(req.url).pathname;

    // only look for this pattern
    if (incominguri == "/reflector")
    {
        // obtain the request level variables
        req_hostname = req.hostname;
        req_baseurl = req.baseUrl;
        req_ipaddr = req.ip; //
        req_protocol = req.protocol; //
        req_method = req.method;
        req_headers = JSON.stringify(req.headers);
        s = JSON.parse(req_headers);
                
        // set some headers
        res.setHeader("Cache-Control", "no-store");
        res.setHeader("Content-Type", "text/html");

        // set the response body
        res.write("<!DOCTYPE html><html>");
        res.write("<h2> Request from edge </h2>");
        res.write("Variables <br />");
        res.write("---------- <br />");
        res.write("Protocol: " + req_protocol + "<br />");
        res.write("Request Method: " + req_method + "<br />");
        res.write("Request URI: " + incominguri + "<br />");
        res.write("Client IP: " + req_ipaddr + "<br />");
        res.write("---------- <br /><br />");
        res.write("Incoming Request Headers <br />");
        res.write("---------- <br />");        

        // dump out all the headers
        for (var name in s)
        {
            res.write(name + ": " + s[name] + "<br />");
        
        } // end for

        res.write("</html>");

    } // end if

    // write the response to user
    res.end();
    
}; // end dumpheader

// create a server and listener
var server = http.createServer(dumpheader);
server.listen(8080);
