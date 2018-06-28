
var globalMap1;
var globalMap2;
var globalMap3;
var marker;
var markers =[];
function cambiarOpcion(opcion) {
        switch (opcion) {
            case "1":
                $('#p1').show(); //muestro mediante id
                $('#p2').hide(); //oculto mediante id       
                $('#p3').hide(); //oculto mediante id
                $('#p4').hide(); //oculto mediante id                
                $('#p5').hide(); //oculto mediante id
                $('#result1').hide();
                $('#result2').hide();
                $('#result3').hide();
                $('#map1').hide();
                $('#map2').hide();
                $('#map3').hide();
                break;
            case "2":
                $('#p2').show(); //muestro mediante id
                $('#p1').hide(); //oculto mediante id       
                $('#p3').hide(); //oculto mediante id
                $('#p4').hide(); //oculto mediante id                
                $('#p5').hide(); //oculto mediante id
                $('#result1').hide();
                $('#result2').hide();
                $('#result3').hide();
                $('#map1').hide();
                $('#map2').hide();
                $('#map3').hide();
                break;
            case "3":
                $('#p3').show(); //muestro mediante id
                $('#p2').hide(); //oculto mediante id       
                $('#p1').hide(); //oculto mediante id
                $('#p4').hide(); //oculto mediante id                
                $('#p5').hide(); //oculto mediante id
                $('#result1').hide();
                $('#result2').hide();
                $('#result3').hide();
                $('#map1').hide();
                $('#map2').hide();
                $('#map3').hide();
                break;
            case "4":
                $('#p4').show(); //muestro mediante id
                $('#p2').hide(); //oculto mediante id       
                $('#p3').hide(); //oculto mediante id
                $('#p1').hide(); //oculto mediante id                
                $('#p5').hide(); //oculto mediante id
                $('#result1').hide();
                $('#result2').hide();
                $('#result3').hide();
                $('#map1').hide();
                $('#map2').hide();
                $('#map3').hide();
                break;
            case "5":
                $('#p5').show(); //muestro mediante id
                $('#p2').hide(); //oculto mediante id       
                $('#p3').hide(); //oculto mediante id
                $('#p4').hide(); //oculto mediante id                
                $('#p1').hide(); //oculto mediante id
                $('#result1').hide();
                $('#result2').hide();
                $('#result3').hide();
                $('#map1').hide();
                $('#map2').hide();
                $('#map3').hide();
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
        $("#simgSitio" + i).empty();
        $("#nombreSitio" + i).empty();
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
            $("#imgSitio" + cont).attr("src",data[i].image);
            $("#tituloSitio" + cont).append(data[i].name);
            $("#nombreSitio" + cont).append(data[i].name);
            $("#direccionSitio" + cont).append(data[i].address);
            $("#descSitio" + cont).append(data[i].description);
            $("#simgSitio" + cont).append('<img src="'+data[i].image+'">');

            if(cont === 1){
                var myLatLng = {lat: parseFloat(data[i].x), lng: parseFloat(data[i].y)};

                globalMap1.setCenter(myLatLng);

                marker = new google.maps.Marker({
                    map: globalMap1,
                    position: myLatLng
                });
                markers.push(marker);

            }else if(cont === 2){
                var myLatLng = {lat: parseFloat(data[i].x), lng: parseFloat(data[i].y)};

                globalMap2.setCenter(myLatLng);

                marker = new google.maps.Marker({
                    map: globalMap2,
                    position: myLatLng
                });
                markers.push(marker);

            }else{
                var myLatLng = {lat: parseFloat(data[i].x), lng: parseFloat(data[i].y)};

                globalMap3.setCenter(myLatLng);

                marker = new google.maps.Marker({
                    map: globalMap3,
                    position: myLatLng
                });
                markers.push(marker);

            }//else-if            
            cont ++;
        }//for
    }, 
    "json");
    $('#result1').show(); //muestro mediante id
    $('#result2').show(); //muestro mediante id
    $('#result3').show(); //muestro mediante id
    $('#map1').show(); //muestro mediante id
    $('#map2').show(); //muestro mediante id
    $('#map3').show(); //muestro mediante id
});


function initMap() {
    var map1 = new google.maps.Map(document.getElementById('map1'), {
        zoom: 12,
        center: {lat: -34.397, lng: 150.644}
    });
    globalMap1 = map1;

     var map2 = new google.maps.Map(document.getElementById('map2'), {
        zoom: 12,
        center: {lat: -34.397, lng: 150.644}
    });
    globalMap2 = map2;


     var map3 = new google.maps.Map(document.getElementById('map3'), {
        zoom: 12,
        center: {lat: -34.397, lng: 150.644}
    });
    globalMap3 = map3;
}//initMap






