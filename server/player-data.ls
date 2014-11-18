
{ log }    = require \../common/helpers
{ Bounds } = require \./bounds

export class PlayerData
  ({ @id, @pos, @color, @size }) ->
    log 'new PlayerData:', @color

  get-bounding-box: -> new Bounds x: @pos.x, y: @pos.y, w: @size.w, h: @size.h

