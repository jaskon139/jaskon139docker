var http = require('http'), httpProxy = require('http-proxy');
var proxy = httpProxy.createProxyServer({});
proxy.on('error', function (err, req, res) {
  res.writeHead(500, {
    'Content-Type': 'text/plain'
  });
  res.end('Something went wrong. And we are reporting a custom error message.');
});
var server = require('http').createServer(function (req, res) {
  var host = req.headers.host, ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
  console.log("host="+host);
  console.log("url="+req.url);
  switch(req.url){
    case '/ssss':
        proxy.web(req, res, { target: 'http://localhost:80' });
    break;
    case '/ssss1':
        proxy.web(req, res, { target: 'http://localhost:1338' });
    break;
    case '/ssss2':
        proxy.web(req, res, { target: 'http://localhost:1339' });
    break;
    default:
        proxy.web(req, res, { target: 'http://localhost:3000' });
//        res.writeHead(200, {
//            'Content-Type': 'text/plain'
//        });
//        res.end('Welcome to my server!');
  }
});
console.log("listening on port 4500")
server.listen(4500);
