// Generated by CoffeeScript 1.4.0
var server, port;

server = require('./.app').server;
port = require('./.app').port;

server.listen(port, function() {
  return console.log("Listening on " + port + "\nPress CTRL-C to stop server.");
});