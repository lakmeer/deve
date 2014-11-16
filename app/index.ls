
log = -> console.log.apply console, &; &0

require! \node-uuid
require! \http
io = require \socket.io

require! \fs



handler = (req, res) ->

  resource = switch req.url
  | '/' => '/index.html'
  | _   => that

  log \res:, resource

  fs.readFile  __dirname + '/../client' + resource,  (err, data) ->
    if (err)
      res.writeHead(500)
      return res.end('Error loading index.html')

    res.writeHead(200)
    res.end(data)


http-server = http.createServer handler
http-server.listen 1337

io = require('socket.io')(http-server)

io.on \connection, (socket) ->
  socket.emit \test, data: \hello
  socket.on \move, ->
    log "Client moved!", &

