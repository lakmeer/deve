
# Require

socket-io = require \socket.io

{ log, map } = require \../common/helpers
{ Bounds } = require \./bounds
{ Client } = require \./client


# Helpers

show-clients = -> log clients.map (.player-data.color)


# State

clients = []


# Exports

export remove-dead-client = (dead-client) ->
    log 'Removing client:', dead-client.player-data.color
    clients := [ client for client in clients when client.id isnt dead-client.id ]
    clients.map (.opponent-has-gone dead-client.player-data)
    show-clients!

export broadcast-movements = (moved-client) ->
    bounds = moved-client.player-data.get-bounding-box!
    for client in clients when client.id isnt moved-client.id
      if Bounds.intersects client.player-data.get-bounding-box!, bounds
        client.has-collided moved-client.player-data
        moved-client.has-collided client.player-data
      client.opponent-has-moved moved-client.player-data

export listen = (http-server) ->

  # Once stated, begin listening to clients and assigning them Client objects
  io = socket-io http-server

  io.on \connection, (socket) ->

    # New Client, assign callbacks
    client = new Client socket
    client.on-moved broadcast-movements
    client.on-disconnected remove-dead-client

    # Tell everyone else about newcomer, tell newcomer about everyone else
    clients.map (.opponent-has-joined client.player-data)
    clients.map -> client.opponent-has-joined it.player-data

    # Add to clients collection
    clients.push client
    show-clients!

