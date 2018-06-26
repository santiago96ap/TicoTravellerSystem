  function cambiarOpcion(opcion) {
        switch (opcion) {
            case "1":
                $('#p1').show(); //muestro mediante id
                $('#p2').hide(); //oculto mediante id       
                $('#p3').hide(); //oculto mediante id
                $('#p4').hide(); //oculto mediante id                
                $('#p5').hide(); //oculto mediante id
                break;
            case "2":
                $('#p2').show(); //muestro mediante id
                $('#p1').hide(); //oculto mediante id       
                $('#p3').hide(); //oculto mediante id
                $('#p4').hide(); //oculto mediante id                
                $('#p5').hide(); //oculto mediante id
                break;
            case "3":
                $('#p3').show(); //muestro mediante id
                $('#p2').hide(); //oculto mediante id       
                $('#p1').hide(); //oculto mediante id
                $('#p4').hide(); //oculto mediante id                
                $('#p5').hide(); //oculto mediante id
                break;
            case "4":
                $('#p4').show(); //muestro mediante id
                $('#p2').hide(); //oculto mediante id       
                $('#p3').hide(); //oculto mediante id
                $('#p1').hide(); //oculto mediante id                
                $('#p5').hide(); //oculto mediante id
                break;
            case "5":
                $('#p5').show(); //muestro mediante id
                $('#p2').hide(); //oculto mediante id       
                $('#p3').hide(); //oculto mediante id
                $('#p4').hide(); //oculto mediante id                
                $('#p1').hide(); //oculto mediante id
                break;
            default:
                break;
        }//switch
    }//cambiarOpcion


$("#send-info").click(function () {

    alert($("#ps1").val());

        var parameters = {
            "typeDestination" : $("#ps1").val(),
            "price" : $("#ps2").val(),
            "preferencePlace" : $("#ps3").val(),
            "time":  $("#ps4").val(),
            "roadType":  $("#ps5").val()
        };

        $.post("?controller=Site&action=getSimilarity", parameters, function (data) {

            alert(data);

            for (var i = 0; i < data.length; i++) {
                alert(data[i].name);
            }
        }, "json");

});



