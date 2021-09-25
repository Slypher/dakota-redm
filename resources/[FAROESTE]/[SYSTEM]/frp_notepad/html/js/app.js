var ownerdNotepad;
var notepadreader;

document.onkeydown = function (data) {
    if (data.which == 27) { // Escape 
        $.post('http://frp_notepad/escape', JSON.stringify({}));
        }
    
};

function dropNotepad() {
    var x = document.getElementById("p1").value;
    if (x == ""){
        $.post('http://frp_peagle/droppingEmpty', JSON.stringify({}));
    }else {
        $.post('http://frp_peagle/dropping', JSON.stringify({ text: x}));
        $("#main").fadeOut();
        document.getElementById("p1").value = "";
        $("#main").css('display', 'none');
    }   
}

window.addEventListener('message', function(event) {
    switch(event.data.action) {
        case 'openNotepad':
            if (ownerdNotepad === undefined){
                document.getElementById("p1").value = "";
                $("#main").fadeIn();
            }else {
                $("textarea").removeAttr('disabled','disabled');
                $("button").fadeIn();
                document.getElementById("p1").value = ownerdNotepad;
                $("#main").fadeIn();
            }
            break;
        case 'openNotepadRead':
            notepadreader = true;
            $("textarea").attr('disabled','disabled');
            $("button").hide();
            $("#main").fadeIn();
            document.getElementById("p1").value = event.data.TextRead;
            break;
        case 'closeNotepad':
            $("#main").fadeOut();
            $("#main").css('display', 'none');
            break;
        case 'cleanNotepad':
            document.getElementById("p1").value = "";
            break;
    }
});




