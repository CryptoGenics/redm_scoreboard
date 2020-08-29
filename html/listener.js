var ShowPing = true;

$(function() {
    window.addEventListener('message', function(event) {
        var item = event.data;
        var buf = $('#wrap');
        if (ShowPing) {
            buf.find('table').append("<tr class=\"heading\"><th width=\"2\">ID</th><th>Name</th><th>Ping</th></tr>");
        } else {
            buf.find('table').append("<tr class=\"heading\"><th>ID</th><th>Name</th></tr>");
        }
        if (item.meta && item.meta == 'close')
        {
            document.getElementById("player_table").innerHTML = "";
            $('#wrap').hide();
            return;
        }
        buf.find('table').append(item.text);
        $('#wrap').show();
    }, false);
});