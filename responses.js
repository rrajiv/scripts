var restify = require('restify');
var errs = require('restify-errors');

function senderror(req, res, next) 
{
	// read the incoming response code
	var respcode = req.params.responsecode;

	// do some selective response codes	
	if (respcode == "404")
		next(new errs.NotFoundError());
	else if (respcode == "403")
		next(new errs.ForbiddenError());
	else if (respcode == "429")
		next(new errs.TooManyRequestsError());
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

server.listen(8082, function() {
  console.log('%s listening at %s', server.name, server.url);
});