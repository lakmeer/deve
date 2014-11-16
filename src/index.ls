
# Program index

log = -> console.log.apply console, &; &0

px = (+ \px)



class Connection

  (@port = 3001) ->


class Player
  ->
    log "New Player"
    @x = 0
    @y = 0
    @w = 20
    @h = 20

    @view = document.create-element \div
    @view.style <<< {
      background-color: \red
      height: px @h
      width: px @w
      position: \absolute
    }


  install: (host) ->
    host.append-child @view

  look-at: ({ x, y }) ->

  move-to: ({ x, y }) ->
    log "Player::move-to", x, y
    @x = x
    @y = y

  update-view: ->
    log "Player:update-view", @x, @y
    @view.style.left = px @x - @w /2
    @view.style.top  = px @y - @h /2



# Controller

me = new Player


field = document.create-element \div
field.style <<< { position: \absolute, height: \100%, width: \100%, background-color: \black }

me.install field

document.body.append-child field


field.add-event-listener \click, ({ clientX: x, clientY: y }) ->
  log \clicked?
  me.move-to { x, y }
  me.update-view!


