    var globalMap;
    var marker;
     var arraySitios = [];

    function obtenerNombreSitios(){
        $.post("?controller=Site&action=allSitesName",null, function(data){
            var sitios = JSON.parse(data);
            
            for (var i = 0; i < sitios.length; i++) {
               arraySitios.push(sitios[i].name);
}
        });
    };

    $('#search').click(function(){
        var parameters = {"name" : $('#nSitio').val()};
        $.post("?controller=Site&action=searchSite",parameters, function(data){
            var sitios = JSON.parse(data);
            $('#result').show();
            $('#map').show();
            //alert(data);
            document.getElementById('nombreSitio').innerHTML = sitios[1];
            document.getElementById('nombreSitioModal').innerHTML = sitios[1];
            document.getElementById('direccionSitioModal').innerHTML = sitios[2];
            document.getElementById('descripcionSitioModal').innerHTML = sitios[3];
            document.getElementById('imgSitio1').src = sitios[6];
            document.getElementById('simgSitio').innerHTML = '<img src="'+sitios[6]+'">';
            //$("#simgSitio").append('<img src="'+sitios[6]+'">');
            
            marker.setMap(null);

                var myLatLng = {lat: parseFloat(sitios[4]), lng: parseFloat(sitios[5])};

                globalMap.setCenter(myLatLng);

                marker = new google.maps.Marker({
                    map: globalMap,
                    position: myLatLng
                });
                markers.push(marker);
        });
    });

    function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 12,
            center: {lat: -34.397, lng: 150.644}
        });
        globalMap = map;
        var myLatLng = {lat: -34.397, lng: 150.644};
        marker = new google.maps.Marker({
            map: globalMap,
            position: myLatLng
        });
        markers.push(marker);
    }

    $(document).ready(function(){
        obtenerNombreSitios();
        initMap();
    });

   $( function() {
    $( "#nSitio" ).autocomplete({
      source: arraySitios
    });
  } );
