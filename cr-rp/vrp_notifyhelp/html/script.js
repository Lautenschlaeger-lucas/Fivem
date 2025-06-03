window.addEventListener('message', function (event) {
    var msgaction = event.data.action;
    var msg = event.data;
    switch (msgaction) {
        case 'notification':
            showNotification(msg.KeyMapping, msg.info, msg.show);
        break;
    }
});

function showNotification(KeyMapping, info, show) {
    if (show === true) {
        document.getElementById('KeyMapping').innerHTML = KeyMapping;
        document.getElementById('info').innerHTML = info;
        $('.box').fadeIn(300)
    } else if (show === false) {
        $('.box').fadeOut(300)
    }
}