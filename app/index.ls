
log = -> console.log.apply console, &; &0
random-from = (l) -> l[ Math.floor Math.random! * l.length ]
map = (λ, l) --> [ λ x for x in l ]

require! \fs
require! \http
require! \node-uuid
socket-io = require \socket.io


handler = (req, res) ->

  resource = switch req.url
  | '/' => '/index.html'
  | _   => that

  fs.readFile  __dirname + '/../client' + resource,  (err, data) ->
    if (err)
      res.writeHead(500)
      return res.end('Error loading index.html')

    res.writeHead(200)
    res.end(data)


http-server = http.createServer handler
http-server.listen 1337


clients = []

abs = Math.abs

class Bounds
  ({ @x, @y, @w, @h }) ->

  @intersects = (a, b) ->
    (abs(a.x - b.x) * 2 < (a.w + b.w)) and (abs(a.y - b.y) * 2 < (a.h + b.h))


class PlayerData
  ({ @id, @pos, @color, @size }) ->
    log 'new PlayerData:', @color

  get-bounding-box: -> new Bounds x: @pos.x, y: @pos.y, w: @size.w, h: @size.h


class Client

  colors = <[ red blue green yellow orange purple ]>

  (@socket) ->
    @id    = socket.conn.id
    log "New client:", @id

    @player-data = new PlayerData do
      id: @id
      pos: { x: 0, y: 0 }
      size: { w: 20, h: 20 }
      color: random-from colors

    @socket.emit \joined, @player-data

    @socket.on \move, (pos) ~>
      @player-data.pos = pos
      broadcast-movements this

    @socket.on \disconnect, ~>
      remove-dead-client this

  opponent-has-joined: (data) ->
    @socket.emit \opponent-has-joined, data

  opponent-has-moved: (data) ->
    @socket.emit \opponent-has-moved, data

  opponent-has-gone: (data) ->
    @socket.emit \opponent-has-gone, data



io = socket-io http-server

io.on \connection, (socket) ->
  client = new Client socket
  clients.map (.opponent-has-joined client.player-data)
  clients.map -> client.opponent-has-joined it.player-data
  clients.push client
  show-clients!

show-clients = -> log (clients |> map (.player-data.color))

remove-dead-client = (dead-client) ->
  log 'Removing client:', dead-client.player-data.color
  clients := [ client for client in clients when client.id isnt dead-client.id ]
  clients.map (.opponent-has-gone dead-client.player-data)
  show-clients!

broadcast-movements = (moved-client) ->
  bounds = moved-client.player-data.get-bounding-box!

  for client in clients when client.id isnt moved-client.id
    if Bounds.intersects client.player-data.get-bounding-box!, bounds
      log 'collided!'
    client.opponent-has-moved moved-client.player-data

