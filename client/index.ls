
# Require

io = require \socket.io-client

map = (λ, l) --> [ λ x for x in l ]


# Helpers

log = -> console.log.apply console, &; &0
px = (+ \px)
swallow = (λ) -> -> it.prevent-default!; λ ...


# Classes

class Connection
  (@port = 3001) ->

class Player
  ({ @id, @color, @size, @pos }:data) ->
    log "New Player", @color, data

    @view = document.create-element \div
    @view.style <<< {
      background-color: @color
      height: px @size.h
      width: px @size.w
      left: px @pos.x
      top: px @pos.y
      position: \absolute
    }

  show-collision: ->
    @view.style.border = "2px solid red"
    set-timeout (~> @view.style.border = "none"), 1000

  install:   (host) -> host.append-child @view
  uninstall: -> this.view.parent-node.remove-child this.view

  look-at: ({ x, y }) ->

  set-pos: -> @move-to ...

  move-to: ({ x, y }) ->
    log "Player(#{@id})::move-to", x, y
    @pos.x = x
    @pos.y = y

  update-view: ->
    log "Player(#{@id}):update-view", @pos
    @view.style.left = px @pos.x - @size.w /2
    @view.style.top  = px @pos.y - @size.h /2



# Controller

me = void
players = {}

field = document.create-element \div
field.style <<< { position: \absolute, height: \100%, width: \100%, background-color: \black }
document.body.append-child field

update-everyone = ->
  for id, player of players
    player.update-view!

state = mousedown: no

field.add-event-listener \mousedown, -> state.mousedown = yes
field.add-event-listener \mouseup,   -> state.mousedown = no
field.add-event-listener \mousemove, swallow ({ clientX: x, clientY: y }) ->
  if state.mousedown
    me.move-to { x, y }
    socket.emit \move, { x, y }
    me.update-view!

field.add-event-listener \touchstart, -> state.mousedown = yes
field.add-event-listener \touchend,   -> state.mousedown = no
field.add-event-listener \touchmove, swallow ({ clientX: x, clientY: y }) ->
  if state.mousedown
    me.move-to { x, y }
    socket.emit \move, { x, y }
    me.update-view!


# connection

socket = io "#{location.protocol}//#{location.hostname}:#{location.port}"

socket.on \joined, (data) ->
  players := {}
  me := new Player data
  me.install field
  players[me.id] = me
  socket.emit \move, { x: me.x, y: me.y }

socket.on \opponent-has-joined, ({ color }:data) ->
  log 'Socket::opponent-has-joined', color
  player = new Player data
  player.install field
  players[player.id] = player
  update-everyone!

socket.on \opponent-has-moved, ({ id, pos, color }) ->
  log 'Socket::opponent-has-moved', color
  players[id]?.set-pos pos
  update-everyone!

socket.on \opponent-has-gone, ({ id, color }:data) ->
  log 'Socket::opponent-has-gone', color
  players[id].uninstall!
  delete players[id]

socket.on \has-collided, ({ id }) ->
  me.show-collision!
  players[id].show-collision!

