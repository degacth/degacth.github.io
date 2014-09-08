require [
  '/puzzle/assets/coffee/Puzzle.js'
  '/bower_components/handlebars/handlebars.min.js'
  '/bower_components/swag/lib/swag.min.js'
], (Puzzle, Handlebars) ->
  class Main
    constructor: ->
      Swag.registerHelpers Handlebars

      @imagesPath = '/puzzle/images/'
      @settingCtx = '#settings'
      @ranger = $ 'input.ranger'
      @grid = @ranger.val()
      @thumbnail =
        canvas: thumbnail
        ctx: thumbnail.getContext '2d'
        parent: $(thumbnail).parent()

      @thumbnail.canvas.width = @thumbnail.canvas.height = @thumbnail.parent.height()

      imagesTemplate = Handlebars.compile @templates.imageList
      $ '.images', @settingCtx
        .html imagesTemplate images: @images

      radIndex = @_getRandom 0, @images.length - 1
      @image = (@images[radIndex])[0]

      @puzzle = new Puzzle 'puzzle'
      @puzzle.setImagePath @_getFullPath @image
      @puzzle.setGrid @grid
      @puzzle.init()

      @_initEvents()

    setGrid: =>
      @grid = @ranger.val()
      @updateThumbnail()

    setImagePath: (e) =>
      @image = $ e.target
        .data 'path'

      @updateThumbnail()

    updateThumbnail: =>
      img = @_getFullPath @image
      unless @puzzle.im.get img
        @puzzle.im.addImage img, img
        return @puzzle.im.load @updateThumbnail

      img = @puzzle.im.get img
      len = Math.min img.width, img.height

      ctx = @thumbnail.ctx
      size = @thumbnail.canvas.width
      ctx.drawImage img,
        (img.width - len) / 2,
        (img.height - len) / 2,
        len, len,
        0, 0,
        size, size

      # Рисуем сетку
      step = Math.round size / @grid
      ctx.lineWidth = 3
      ctx.strokeStyle = '#ffffff'

      drawLines = (line) ->
        ctx.beginPath()
        ctx.moveTo line * step, 0
        ctx.lineTo line * step, size

        ctx.moveTo 0, line * step
        ctx.lineTo size, line * step
        ctx.stroke()

      drawLines lines for lines in [0...@grid]

    applyThumbnail: =>
      @puzzle.setImagePath @_getFullPath @image
      @puzzle.setGrid @grid
      @puzzle.init()

    _initEvents: ->
      @ranger. on 'change', @setGrid
      $ document
        .on 'click', "#{@settingCtx} .images .image-button", @setImagePath

      $ '.apply-button'
        .on 'click', @applyThumbnail

      $ '.uk-icon-photo'
        .on 'click', @puzzleThumbnail

    puzzleThumbnail: (e) =>
      $this = $ e.target
      @puzzle.showThumbnail() if $this.hasClass 'hide'
      else @puzzle.draw()

    images:[
      ['0b139e316d32f50ef853d14c99ba9dc7.jpg', 'Жалкий кот']
      ['1298908073_D8F0E5EA203464.jpg', 'Куча шреков']
      ['1364573183-785.jpg', 'Медвевь и самовар']
      ['1520-spider-man-1920x1080-movie-wallpaper.jpg', 'ЧелоПук']
      ['7880-angry-birds-1920x1080-game-wallpaper.jpg', 'Злостные птицы']
      ['anywalls.com-39973.jpg', 'Мегавольт']
      ['batman-fan-art-wallpaper-1920-1080-6531.jpg', 'Бетман']
      ['clumsy-the-smurfs-2-21626-1920x1080.jpg', 'Смурф']
      ['hq-wallpapers_ru_cartoons_59495_1920x1080.jpg', 'Монстры']
      ['kitty-and-puss-wallpaper.jpg', 'Китти и кот']
      ['kungfupanda.jpg', 'Панда кунг-фу']
      ['motto.net.ua-18208.jpg', 'Маша']
      ['motto.net.ua-24980.jpg', 'Оптимус Прайм']
      ['motto.net.ua-7516.jpg', 'Тачки']
      ['motto.net.ua-876.jpg', 'Чёрный плащь']
      ['scrooge.jpg', 'Скрудж']
      ['tangled-musical-film-1920x1080-wallpaper-4651.jpg', 'Красно-девица']
      ['tt0400717.jpg', 'Звери']
      ['vinney.jpg', 'Винни Пух']
      ['wwalls.ru-42830.jpg', 'Чужой']
    ]

    templates:
      imageList: '''
        {{#eachIndex images}}
          <li>
            <span data-path="{{first item}}" class="image-button">{{last item}}</span>
          </li>
        {{/eachIndex}}
      '''

    _getRandom: (min, max) -> Math.floor( Math.random() * (max - min + 1) ) + min
    _getFullPath: (filename) -> "#{@imagesPath}#{filename}"

  new Main

  $ '.ranger'
    .ranger
      vertical: true