define [
  './EventEmitter.js'
], (EventEmitter) ->

  class InputHandlerBase extends EventEmitter
    constructor: (@_element) ->
      super

      @_lastMoveCoordinates = null
      @_moving = false
      @_moveThreshold = 10
      @_stopDomEvents = true

    setMoveThreshold: (value) -> @_moveThreshold = value
    setStopDomEvents: (value) -> @_stopDomEvents = value
    getMoveThreshold: -> @_moveThreshold
    getStopDomEvents: -> @_stopDomEvents

    _onDownDomEvent: (e) ->
      coords = @_lastMoveCoordinates = @_getInputCoordinates e
      @emit 'down',
        x: coords.x
        y: coords.y
        domEvent: e

      @_stopEventIfRequired e

    _onUpDomEvent: (e) ->
      coords = @_getInputCoordinates e
      @emit 'up',
        x: coords.x
        y: coords.y
        moved: @_moving
        domEvent: e

      @_moving = false

    _onMoveDomEvent: (e) ->
      coords = @_getInputCoordinates e
      deltaX = coords.x - @_lastMoveCoordinates.x
      deltaY = coords.y - @_lastMoveCoordinates.y

      if not @_moving and Math.sqrt( Math.pow(deltaX, 2) + Math.pow(deltaY, 2) ) > @_moveThreshold then @_moving = true

      if @_moving
        @emit 'move',
          x: coords.x
          y: coords.y
          deltaX: deltaX
          deltaY: deltaY
          domEvent: e

        @_lastMoveCoordinates = coords

      @_stopEventIfRequired e

    _stopEventIfRequired: (e) ->
      if @_stopDomEvents
        e.stopPropagation()
        e.preventDefault()

    _getInputCoordinates: (e) ->
      coords = if e.targetTouches then e.targetTouches[0] else e

      x: (coords.pageX || coords.clientX + document.body.scrollLeft) - @_element.offsetLeft
      y: (coords.pageY || coords.clientY + document.body.scrollTop) - @_element.offsetTop
