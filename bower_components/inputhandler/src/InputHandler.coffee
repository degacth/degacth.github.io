define [
  './MouseInputHandler.js'
  './TouchInputHandler.js'
], (MouseInputHandler, TouchInputHandler) ->
  InputHandler = if 'ontouchstart' of document.documentElement then TouchInputHandler else MouseInputHandler