
export id = ->
  it

export log = ->
  console.log.apply console, &; &0

export map = (λ, xs) -->
  [ λ x, i for x, i in xs ]

export abs = Math.abs

export random-from = (list) ->
  list[ Math.floor Math.random! * list.length ]

