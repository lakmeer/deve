
# Require

require! \fs
require! \http
require! \node-uuid

{ SocketServer } = require \./socket-server


# Helpers

{ log, map, abs, random-from } = require \../common/helpers


# Start HTTP Server

http-server = http.create-server (req, res) ->

  resource = switch req.url
  | '/' => '/index.html'
  | _   => that

  fs.readFile  __dirname + '/../client' + resource,  (err, data) ->
    if (err)
      res.writeHead(500)
      return res.end('Error loading index.html')

    res.writeHead(200)
    res.end(data)

http-server.listen 1337


# Attach socket server to existing webserver

SocketServer.connect http-server

