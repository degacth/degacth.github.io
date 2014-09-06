define [
  './InputHandlerBase.js'
], (InputHandlerBase) ->

  class TouchInputHandler extends InputHandlerBase
    constructor: (element) ->
      super element

      @_lastInteractionCoordinates = null
      @_attachDomListeners()

    _attachDomListeners: ->
      @_element.addEventListener 'touchstart', @_onDownDomEvent
      @_element.addEventListener 'touchend', @_onUpDomEvent
      @_element.addEventListener 'touchmove', @_onMoveDomEvent

    _onDownDomEvent: (e) =>
      @_lastInteractionCoordinates = @_getInputCoordinates e
      super e

    _onUpDomEvent: (e) =>
      @emit 'up',
        x: @_lastInteractionCoordinates.x
        y: @_lastInteractionCoordinates.y
        moved: this._moving
        domEvent: e

      @_stopEventIfRequired e
      @_lastInteractionCoordinates = null
      @_moving = false

    _onMoveDomEvent: (e) =>
      @_lastInteractionCoordinates = @_getInputCoordinates e
      super e
