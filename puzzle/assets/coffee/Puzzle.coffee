define [
  '/bower_components/inputhandler/dist/InputHandler.js'
  '/bower_components/imagemanager/dist/ImageManager.js'
], (InputHandler, ImageManager) ->

  class Puzzle
    constructor: (@parentId, @grid, images) ->
      @outlineWidth = 1
      @outlineColor = '#F5FE4B'
      @active = -1

      @parent = document.getElementById @parentId

      @canvas = document.createElement 'canvas'
      @ctx = @canvas.getContext '2d'
      @input = new InputHandler @canvas

      @im = new ImageManager images

      @im.load(@imagesLoaded)

    resize: =>
      width  = @parent.width || @parent.clientWidth;
      height = @parent.height || @parent.clientHeight;

      @canvas.width = @canvas.height = Math.min width, height
      @img = @_squareImage()
      @setSize()
      @draw()

    setSize: ->
      @size = Math.round @canvas.width / @grid
      @outlineWidth = Math.min 8, Math.round(@size / 30)

    imagesLoaded: =>
      @_initMap()
      @_initFullScreen()
      @_initEvents()

    draw: =>
      @ctx.clearRect 0, 0, @canvas.width, @canvas.height

      @_drawTile tile, index for tile, index in @map
      if @active > -1 then @_drawTile @map[@active], @active, true

    move: (e) =>
      @actPos.x += e.deltaX
      @actPos.y += e.deltaY

      @draw()

    up: (e) =>
      drop = @_getIndexByCoords e
      activeTile = @map[@active]
      @map[@active] = @map[drop]
      @map[drop] = activeTile

      @active = -1
      @_resetActPos()
      @draw()
      @checkWin()

    down: (e) =>
      @active = @_getIndexByCoords e
      @_resetActPos()

    showThumbnail: ->
      @draw()
      @ctx.fillStyle = "rgba(0, 0, 0, .5)"
      @ctx.fillRect 0, 0, @canvas.width, @canvas.height

      padding = 4
      pos = Math.round @canvas.width / padding
      length = (padding-2)*pos
      @ctx.drawImage @img,
        0, 0, @img.width, @img.width,
        pos, pos, length, length

      @_strokeSquare(pos, pos, length)


    checkWin: ->
      win = true
      win = ( tile is index and win ) for tile, index in @map

      @showCongratulation() if win

    showCongratulation: ->
      @ctx.drawImage @img,
        0, 0, @canvas.width, @canvas.height

    _getIndexByCoords: (e) -> Math.floor(e.y / @size) * @grid + Math.floor(e.x / @size)

    _drawTile: (tile, index, isActive = false) ->
      if index is @active and not isActive then return

      getPos = (i) =>
        x: (i % @grid) * @size
        y: Math.floor(i / @grid) * @size

      dist = getPos index
      if isActive
        dist.x += @actPos.x
        dist.y += @actPos.y

      src = getPos tile

      # Отрисовываем тайл
      @ctx.drawImage @img,
        src.x, src.y, @size, @size,
        dist.x, dist.y, @size, @size

      @_strokeSquare dist.x, dist.y, @size

    _strokeSquare: (x, y, size) ->
      @ctx.beginPath()
      @ctx.lineWidth = @outlineWidth
      @ctx.moveTo x, y
      @ctx.lineTo x += size, y
      @ctx.lineTo x, y += size
      @ctx.lineTo x -= size, y

      @ctx.lineJoin = 'bevel'
      @ctx.closePath()
      @ctx.strokeStyle = @outlineColor
      @ctx.stroke()

    _initFullScreen: ->
      @parent.appendChild @canvas

      window.addEventListener 'resize', @resize
      @resize()

    _initEvents: ->
      @input.on 'move', @move
      @input.on 'up', @up
      @input.on 'down', @down

    _initMap: ->
      @map = @_shuffle [ 0...Math.pow @grid, 2 ]

    _shuffle: (map) ->
      for i in [map.length - 1 .. 0]
        rand = Math.floor( Math.random() * (i + 1) )
        randTile = map[rand]
        map[rand] = map[i]
        map[i] = randTile

      map

    _squareImage: (img) ->
      canvas = document.createElement 'canvas'
      canvas.width = canvas.height = @canvas.width
      ctx = canvas.getContext '2d'

      img = @im.get 'picture'
      lenght = Math.min img.width, img.height

      ctx.drawImage img,
        (img.width - lenght) / 2,
        (img.height - lenght) / 2,
        lenght, lenght,

        0, 0, canvas.width, canvas.height

      @img = canvas

    _resetActPos: ->
      @actPos =
        x: 0
        y: 0
