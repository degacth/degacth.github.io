# InputHandler
Данный набор классов основан на записях книги "Pro android Web game apps" автора Juriy Bura (к сожалению на английском языке),
которые любезно перепесанны на CoffeeScript с незначительными изменениями.

## Insтановка
```
bower i inputhandler
```

## How to взъюзывать
```
<script data-main="main" src="/bower_components/requirejs/require.js"></script>
```

Далее клиентский код (coffeescript) грузит InputHandler.js и создаёт экземпляр свежезагруженного класса, после чего начинает слушать 
соответствующие события
```
require [
    '/path/to/InputHandler.js'
], (InputHandler) ->
    element = document.getElementById 'element'
    input = new InputHandler element
```
```
    input.on 'down', (e) -> console.log e
    input.on 'up', (e) -> console.log e
    input.on 'move', (e) -> console.log e
```

```
git remote add origin git@github.com:degacth/InputHandler.git
git push -u origin master
```