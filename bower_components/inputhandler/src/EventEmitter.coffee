define -> EventEmitter

class EventEmitter
  _listeners: {}

  constructor: ->
  addListener: @on

  on: (type, listener) ->
    unless @_isFunc listener then @_exception()
    unless @_isType type then @_listeners[type] = []

    @_listeners[type].push listener

  removeListener: (type, listener) ->
    unless @_isFunc listener then @_exception()
    unless @_isType type then return

    position = @_listeners[type].indexOf listener
    if position isnt -1 then @_listeners[type].splice position, 1

  removeAllListeners: (type) ->
    if type then @_listeners[type] = []
    else @_listeners = {}

  emit: (type, event) ->
    unless @_isType(type) and @_listeners[type].length then return
    t.apply @, [event] for t in @_listeners[type]

  _exception: -> throw 'Listener must be a function'
  _isType: (type) -> @_listeners[type]?
  _isFunc: (listener) -> typeof listener is 'function'
