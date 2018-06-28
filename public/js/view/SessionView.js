

$("#send-info").click(function () {

    var parameters = {
        "userName":$("#userName").val(),
        "pass":$("#pass").val()
    };
    $.post("?controller=Session&action=validateSession", parameters, function (data) {
        if (data.result==="1") {
           setTimeout("location.href = '?controller=Index&action=indexADM';", 100);
        }else{
            alert("Solicitud ejecutada incorrectamente");
        }
    }, "json");
});