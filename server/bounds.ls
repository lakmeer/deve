
{ log, abs } = require \../common/helpers

export class Bounds
  ({ @x, @y, @w, @h }) ->

  @intersects = (a, b) ->
    (abs(a.x - b.x) * 2 < (a.w + b.w)) and (abs(a.y - b.y) * 2 < (a.h + b.h))

