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


    function enviarDatosRecomendacion(){

        alert(
            " \n preferencePlace: "+ $("#ps1").val() +
            " \n destinationType: "+  $("#ps2").val()
            + " \n price:" + $("#ps3").val() 
            + " \n time:" + $("#ps4").val() 
            +  " \n road:" + $("#ps5").val());

        var parametros = {
            "preferencePlace" : $("#ps1").val(),
            "destinationType" : $("#ps2").val(),
            "price" : $("#ps3").val(),
            "time":  $("#ps4").val(),
            "road":  $("#ps5").val()
        };
        $.ajax({
                data:  parametros,
                url:   '?controller=Site&action=getCategorySites',
                type:  'post',
                beforeSend: function () {},
                success:  function (response) {
                    alert(response);
                }
        });


    }//enviarDatosRecomendacion



