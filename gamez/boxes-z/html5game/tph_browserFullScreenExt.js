function initHtmlFullScreenToggler() {
    var fullscr = document.createElement('button')
    fullscr.textContent = '[]'
    fullscr.style.position = 'fixed'
    fullscr.style.bottom = '10px'
    fullscr.style.left = '10px'
    fullscr.style.border = '1px solid white'
    fullscr.style.borderRadius = '3px'
    fullscr.style.color = 'white'
    fullscr.style.backgroundColor = 'black'
    fullscr.style.padding = '2px'

    document.body.appendChild(fullscr)

    function ToggleFullScreen() {
        if ((document.fullScreenElement && document.fullScreenElement !== null) || (!document.mozFullScreen && !document.webkitIsFullScreen)) {
            if (document.documentElement.requestFullScreen) {
                document.documentElement.requestFullScreen();
            } else if (document.documentElement.mozRequestFullScreen) {
                document.documentElement.mozRequestFullScreen();
            } else if (document.documentElement.webkitRequestFullScreen) {
                document.documentElement.webkitRequestFullScreen(Element.ALLOW_KEYBOARD_INPUT);
            }
        } else {
            if (document.cancelFullScreen) {
                document.cancelFullScreen();
            } else if (document.mozCancelFullScreen) {
                document.mozCancelFullScreen();
            } else if (document.webkitCancelFullScreen) {
                document.webkitCancelFullScreen();
            }
        }
    }

    fullscr.onclick = ToggleFullScreen
}