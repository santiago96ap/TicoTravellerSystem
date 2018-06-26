
$("#allSites").change(function () {

	if ($("#allSites").val() !== "-1") {

	    var parameters = {
	        "id": $("#allSites").val()
	    };

	    $.post("?controller=Admin&action=getInformationSite", parameters, function (data) {
	        if (data.id) {

	        	document.getElementById("nombre").value = data.name;
	        	document.getElementById("direccion").value = data.address;
	        	document.getElementById("descripcion").value = data.description;
	        	document.getElementById("x").value = data.x;
	        	document.getElementById("x").value = data.y;

	        	document.getElementById("tipoPrecio").value = data.price;
	        	document.getElementById("lugarPreferencia").value = data.preference_place;
	        	document.getElementById("tipoDestino").value = data.destination_type;
	        	document.getElementById("tipoCamino").value = data.travel_time;
	        	document.getElementById("tiempo").value = data.road_type;
	        	document.getElementById("categoria").value = data.class;

	        	document.getElementById("imagen").src = data.image;

	        	var map = new google.maps.Map(document.getElementById('map'), {
			        zoom: 8,
			        center: {lat: -34.397, lng: 150.644}
			    });

	        } else {
	        	alert("Error al cargar los datos");
	        }
	    }, "json");
	}
});

function initMap() {
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 8,
        center: {lat: -34.397, lng: 150.644}
    });
}