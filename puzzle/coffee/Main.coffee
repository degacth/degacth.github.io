require [
  '/puzzle/coffee/Puzzle.js'
], (Puzzle) ->
  new Puzzle 'puzzle', 3, [
    key: 'picture'
    path: './images/scrooge.jpg'
  ]