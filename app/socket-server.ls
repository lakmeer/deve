
# Require

socket-io = require \socket.io

{ log, map } = require \../common/helpers
{ Bounds } = require \./bounds
{ Client } = require \./client


# Helpers

show-clients = -> log (clients |> map (.player-data.color))


# State

clients = []


# SocketServer Singleton

export SocketServer =

  connect: (http-server) ->
    io = socket-io http-server
    io.on \connection, (socket) ->
      client = new Client socket
      clients.map (.opponent-has-joined client.player-data)
      clients.map -> client.opponent-has-joined it.player-data
      clients.push client
      show-clients!

  remove-dead-client: (dead-client) ->
    log 'Removing client:', dead-client.player-data.color
    clients := [ client for client in clients when client.id isnt dead-client.id ]
    clients.map (.opponent-has-gone dead-client.player-data)
    show-clients!

  broadcast-movements: (moved-client) ->
    bounds = moved-client.player-data.get-bounding-box!

    for client in clients when client.id isnt moved-client.id
      if Bounds.intersects client.player-data.get-bounding-box!, bounds
        client.has-collided moved-client.player-data
        moved-client.has-collided client.player-data
      client.opponent-has-moved moved-client.player-data

