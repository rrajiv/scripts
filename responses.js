var restify = require('restify');
var errs = require('restify-errors');

function senderror(req, res, next) 
{
	// read the incoming response code
	var respcode = req.params.responsecode;

    // send the cache control header
//    res.header('Cache-control', 'max-age=20s');

	// do some selective response codes	
	if (respcode == "404")
		next(new errs.NotFoundError());
	else if (respcode == "403")
		next(new errs.ForbiddenError());
	else if (respcode == "429")
		next(new errs.TooManyRequestsError());
  else if (respcode == "416")
		next(new errs.RangeNotSatisfiableError());
  else if (respcode == "401")
		next(new errs.UnauthorizedError());
	else if (respcode == "400")
		next(new errs.BadRequestError());
	else if (respcode == "405")
		next(new errs.MethodNotAllowedError());
	else if (respcode == "410")
		next(new errs.GoneError());				
	else if (respcode == "411")
		next(new errs.LengthRequiredError());				
	else if (respcode == "500")
		next(new errs.InternalServerError());
	else if (respcode == "502")
		next(new errs.BadGatewayError());
	else if (respcode == "503")
		next(new errs.ServiceUnavailableError());
	else if (respcode == "504")
		next(new errs.GatewayTimeoutError());
	else
		res.send();
		next();

} // end function

// creating the server
var server = restify.createServer();

// creating the route and the function
server.get('/responses/:responsecode', senderror);

// listen for requests
server.listen(8082);
