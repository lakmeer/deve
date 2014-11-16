
# Require

io = require \socket.io-client

map = (λ, l) --> [ λ x for x in l ]


# Helpers

log = -> console.log.apply console, &; &0
px = (+ \px)


# Classes

class Connection

  (@port = 3001) ->



class Player

  (@id, @color) ->
    log "New Player", @color
    @x = 0
    @y = 0
    @w = 20
    @h = 20

    @view = document.create-element \div
    @view.style <<< {
      background-color: @color
      height: px @h
      width: px @w
      position: \absolute
    }

  install: (host) ->
    host.append-child @view

  look-at: ({ x, y }) ->

  set-pos: -> @move-to ...

  move-to: ({ x, y }) ->
    log "Player(#{@id})::move-to", x, y
    @x = x
    @y = y

  update-view: ->
    log "Player(#{@id}):update-view", @x, @y
    @view.style.left = px @x - @w /2
    @view.style.top  = px @y - @h /2



# Controller

me = void
players = {}

field = document.create-element \div
field.style <<< { position: \absolute, height: \100%, width: \100%, background-color: \black }
document.body.append-child field

update-everyone = ->
  for id, player of players
    player.update-view!

field.add-event-listener \click, ({ clientX: x, clientY: y }) ->
  me.move-to { x, y }
  socket.emit \move, { x, y }
  me.update-view!


# connection

socket = io "#{location.protocol}//#{location.hostname}:#{location.port}"

socket.on \joined, ({ id, color }) ->
  me := new Player id, color
  me.install field
  players[me.id] = me
  socket.emit \move, { x: me.x, y: me.y }

socket.on \opponent-has-joined, ({ id, color }) ->
  log 'Socket::opponent-has-joined', color
  player = new Player id, color
  player.install field
  players[player.id] = player
  update-everyone!

socket.on \opponent-has-moved, ({ id, pos, color }) ->
  log 'Socket::opponent-has-moved', color
  players[id]?.set-pos pos
  update-everyone!


