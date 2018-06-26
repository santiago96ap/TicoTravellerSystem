<?php
include_once 'public/header.php';
?>
<div class="banner-inner">
</div>
<ol class="breadcrumb">
    <li class="breadcrumb-item">
        <a href="?controller=Index&action=indexADM">Inicio</a>
    </li>
    <li class="breadcrumb-item active">Registar Sitio</li>
</ol>


    <div id="map"></div>
    <div id="right-panel">
                                <input type="text" id="originAddress" placeholder="Dirección">
    <input id="searchOrigin" type="button" value="Buscar">
                                <span id="latitudeA"></span><br>
                            <span id="longitudeA"></span><br>
    
    </div>
    <script>
        
        var activateUpdate = false;
var activeInsert = false;
var indexAtributtes = 0;
var duration = 0;
var markers = [];
var originLatitude, originLongitude, destinyLatitude, destinyLongitude;
var globalMap;

      function initMap() {
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 8,
        center: {lat: -34.397, lng: 150.644}
    });
    globalMap = map;
    var geocoder = new google.maps.Geocoder();

    document.getElementById('searchOrigin').addEventListener('click', function () {
        geocodeAddress(geocoder, map, 1);
    });
}

function geocodeAddress(geocoder, resultsMap, search) {
    var address = '';

    if (search === 1)
        address = document.getElementById('originAddress').value;

    geocoder.geocode({'address': address}, function (results, status) {
        if (status === 'OK') {
            resultsMap.setCenter(results[0].geometry.location);

            var marker = new google.maps.Marker({
                map: resultsMap,
                position: results[0].geometry.location
            });
            markers.push(marker);

            if (search === 1) {
                originLatitude = results[0].geometry.location.lat();
                originLongitude = results[0].geometry.location.lng();
                document.getElementById('latitudeA').innerHTML = 'Latitud: ' + originLatitude;
                document.getElementById('longitudeA').innerHTML = 'Longitud: ' + originLongitude;
            }
        } else {
            alert('Geocode was not successful for the following reason: ' + status);
        }
    });
}
    </script>
    <script async defer
   <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC1JuYmoq83Om5mLz0qyg_k1viClteC2NU&callback=initMap"></script>
    </script>
<?php
include_once 'public/footer.php';
?>  