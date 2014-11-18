
# Require

{ id, log, random-from } = require \../common/helpers
{ PlayerData } = require \./player-data


# Client Class

export class Client

  colors = <[ red blue green yellow orange purple ]>

  (@socket) ->
    @id    = socket.conn.id
    log "New client:", @id

    @player-data = new PlayerData do
      id: @id
      pos: { x: 0, y: 0 }
      size: { w: 20, h: 20 }
      color: random-from colors

    @callbacks =
      move: id
      disconnect: id

    @socket.emit \joined, @player-data

    @socket.on \move, (pos) ~>
      @player-data.pos = pos
      @callbacks.move this

    @socket.on \disconnect, ~>
      @callbacks.disconnect this

  # External callbacks
  on-moved:        (λ) -> @callbacks.move = λ
  on-disconnected: (λ) -> @callbacks.disconnect = λ

  # External methods
  opponent-has-joined: (data) -> @socket.emit \opponent-has-joined, data
  opponent-has-moved:  (data) -> @socket.emit \opponent-has-moved, data
  opponent-has-gone:   (data) -> @socket.emit \opponent-has-gone, data
  has-collided:        (data) -> @socket.emit \has-collided, data

