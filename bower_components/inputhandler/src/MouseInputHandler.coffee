define [
  './InputHandlerBase.js'
], (InputHandlerBase) ->

  class MouseInputHandler extends InputHandlerBase
    constructor: (element) ->
      super element
      @_mouseDown = false
      @_attachDomListeners()

    _attachDomListeners: ->
      @_element.addEventListener 'mousedown', @_onDownDomEvent, false
      @_element.addEventListener 'mouseup', @_onUpDomEvent, false
      @_element.addEventListener 'mousemove', @_onMoveDomEvent
      @_element.addEventListener 'mouseout', @_onMouseOut

    _onDownDomEvent: (e) =>
      @_mouseDown = true
      super e

    _onUpDomEvent: (e) =>
      @_mouseDown = false
      super e

    _onMoveDomEvent: (e) => if @_mouseDown then super e
    _onMouseOut: () => @_mouseDown = false
