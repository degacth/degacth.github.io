require [
  '/puzzle/assets/coffee/Puzzle.js'
], (Puzzle) ->
  class Main
    constructor: ->

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
#      ['kungfupanda.jpg']
#      ['motto.net.ua-18208.jpg']
#      ['motto.net.ua-24980.jpg']
#      ['motto.net.ua-7516.jpg']
#      ['motto.net.ua-876.jpg']
#      ['multfilmy-bd4fde7d3f49.jpg']
#      ['scrooge.jpg']
#      ['tangled-musical-film-1920x1080-wallpaper-4651.jpg']
#      ['tinker-bell-73790.jpg']
#      ['tt0400717.jpg']
#      ['vinney.jpg']
#      ['wwalls.ru-42830.jpg']
#      ['wwalls.ru-7539.jpg']
    ]

  new Main

  new Puzzle 'puzzle', 3, [
      key: 'picture'
      path: 'images/scrooge.jpg'
    ]

  $ '.ranger'
    .ranger
      vertical: true