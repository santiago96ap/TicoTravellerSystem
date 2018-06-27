
var globalMap;
var marker;

$("#send-info").click(function () {

	var file = document.getElementById("myfile").files[0];
    var datas = new FormData();
	datas.append('file', file);
	datas.append('nombre', $("#nombre").val());
	datas.append('direccion', $("#direccion").val());
	datas.append('descripcion', $("#descripcion").val());
	datas.append('x', $("#x").val());
	datas.append('y', $("#y").val());
	datas.append('tipoPrecio', $("#tipoPrecio").val());
	datas.append('lugarPreferencia', $("#lugarPreferencia").val());
	datas.append('tipoDestino', $("#tipoDestino").val());
	datas.append('tiempo', $("#tiempo").val());
	datas.append('tipoCamino', $("#tipoCamino").val());
	datas.append('categoria', $("#categoria").val());
    
    $.ajax({
        processData: false,
        contentType: false,
        cache: false,
        data: datas,
        url: "?controller=Admin&action=insertSite",
        type: 'post',
        success: function (response) {
            var data = JSON.parse(response);
            if (data.result === '1') {
				alert("Solicitud ejecutada correctamente");
				setTimeout("location.href = '?controller=Index&action=registrarSitio';", 100);
            } else {
               alert("Solicitud ejecutada incorrectamente");
               setTimeout("location.href = '?controller=Index&action=registrarSitio';", 100);
            }
        }
    });
});

$("#send-info-buscar").click(function () {

    var address = '';
    address = document.getElementById('ubicacion').value;
    var geocoder = new google.maps.Geocoder();

    geocoder.geocode({'address': address}, function (results, status) {
        if (status === 'OK') {
            globalMap.setCenter(results[0].geometry.location);

            
            document.getElementById("x").value = results[0].geometry.location.lat();
            document.getElementById("y").value = results[0].geometry.location.lng();

            marker.setMap(null);

            marker = new google.maps.Marker({
                map: globalMap,
                position: results[0].geometry.location
            });
            markers.push(marker);

        } else {
            alert("Error al buscar la ubicacion");
        }
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