define ->
  class ImageManager
    constructor: (@_imageQueue = [], placeholderData = null) ->
      @_images = {}
      @_placeholder = null

      if placeholderData
        @_placeholder = new Image
        @_placeholder.src = placeholderData

    addImage: (key, path) ->
      @_imageQueue.push
        key: key
        path: path

    load: (onDone, onProgress) ->
      noop = ->
      @done = onDone ?= noop
      @progress = onProgress ?= noop
      @counter =
        loaded: 0
        total: @_imageQueue.length

      @_loadItem item for item in @_imageQueue
      @_imageQueue = []

    get: (key) -> @_images[key]

    _loadItem: (item) ->
      img = new Image

      img.onload = =>
        @_images[item.key] = img
        @_onItemLoaded item, true

      img.onerror = =>
        @_images[item.key] = @_placeholder
        @_onItemLoaded item, false

      img.src = item.path
      
    _onItemLoaded: (item, status) ->
      @counter.loaded++
      @progress item, @counter, status

      @done() if @counter.loaded is @counter.total
