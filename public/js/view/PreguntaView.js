

function cambiarOpcion(opcion) {
        switch (opcion) {
            case "1":
                $('#p1').show(); //muestro mediante id
                $('#p2').hide(); //oculto mediante id       
                $('#p3').hide(); //oculto mediante id
                $('#p4').hide(); //oculto mediante id                
                $('#p5').hide(); //oculto mediante id
                $('#resultado').hide();
                break;
            case "2":
                $('#p2').show(); //muestro mediante id
                $('#p1').hide(); //oculto mediante id       
                $('#p3').hide(); //oculto mediante id
                $('#p4').hide(); //oculto mediante id                
                $('#p5').hide(); //oculto mediante id
                $('#resultado').hide();
                break;
            case "3":
                $('#p3').show(); //muestro mediante id
                $('#p2').hide(); //oculto mediante id       
                $('#p1').hide(); //oculto mediante id
                $('#p4').hide(); //oculto mediante id                
                $('#p5').hide(); //oculto mediante id
                $('#resultado').hide();
                break;
            case "4":
                $('#p4').show(); //muestro mediante id
                $('#p2').hide(); //oculto mediante id       
                $('#p3').hide(); //oculto mediante id
                $('#p1').hide(); //oculto mediante id                
                $('#p5').hide(); //oculto mediante id
                $('#resultado').hide();
                break;
            case "5":
                $('#p5').show(); //muestro mediante id
                $('#p2').hide(); //oculto mediante id       
                $('#p3').hide(); //oculto mediante id
                $('#p4').hide(); //oculto mediante id                
                $('#p1').hide(); //oculto mediante id
                $('#resultado').hide();
                break;
            default:
                break;
        }//switch
}//cambiarOpcion

function clean(){
    for (var i = 1; i < 4; i++) {
        $("#tituloSitio" + i).empty();
        $("#direccionSitio" + i).empty();
        $("#descSitio" + i).empty();
        $("#imgSitio" + i).empty();
    }
}



$("#send-info").click(function () {
     
    var parameters = {
        "typeDestination" : $("#ps3").val(),
        "price" : $("#ps2").val(),
        "preferencePlace" : $("#ps1").val(),
        "time":  $("#ps4").val(),
        "roadType":  $("#ps5").val()
    };

    $.post("?controller=Site&action=getSimilarity", parameters, function (data) {
        clean();
        var cont =1;
        for (var i = 0; i < data.length; i++) {
            
            $("#tituloSitio" + cont).append(data[i].name);
            $("#direccionSitio" + cont).append(data[i].address);
            $("#descSitio" + cont).append(data[i].description);
            $("#imgSitio" + cont).attr("src",data[i].image);
            $("#aimgSitio1").attr("href",data[i].image);
            cont ++;
        }//for
    }, 
    "json");
    $('#resultado').show(); //muestro mediante id
});







