
var globalMap;

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

			    switch (data.preference_place) {
		            case "r":
		            	document.getElementById("lugarPreferencia").value ="Rural";
		                break;
		            case "u":
		            	document.getElementById("lugarPreferencia").value ="Urbano";
		                break;
		            default:
		            	document.getElementById("lugarPreferencia").value ="Indefinido";
		                break;
		        }//switch

		        switch (data.price) {
		            case "e":
		            	document.getElementById("tipoPrecio").value ="Económico";
		                break;
		            case "i":
		            	document.getElementById("tipoPrecio").value ="Intermedio";
		                break;
		            case "c":
		            	document.getElementById("tipoPrecio").value ="Costoso";
		                break;
		            default:
		            	document.getElementById("tipoPrecio").value ="Indefinido";
		                break;
		        }//switch

		        switch (data.destination_type) {
		            case "y":
		            	document.getElementById("tipoDestino").value ="Playa";
		                break;
		            case "b":
		            	document.getElementById("tipoDestino").value ="Montaña";
		                break;
		            default:
		            	document.getElementById("tipoDestino").value ="Indefinido";
		                break;
		        }//switch

		        switch (data.travel_time) {
		            case "a":
		            	document.getElementById("tiempo").value ="Menos de 1 hora";
		                break;
		            case "b":
		            	document.getElementById("tiempo").value ="Entre 1-2 horas";
		                break;
		            case "c":
		            	document.getElementById("tiempo").value ="Más de 3 horas";
		                break;
		            default:
		            	document.getElementById("tiempo").value ="Indefinido";
		                break;
		        }//switch

		        switch (data.road_type) {
		            case "v":
		            	document.getElementById("tipoCamino").value ="Asfalto";
		                break;
		            case "p":
		            	document.getElementById("tipoCamino").value ="Lastre";
		                break;
		            default:
		            	document.getElementById("tipoCamino").value ="Indefinido";
		                break;
		        }//switch

	        	document.getElementById("categoria").value = data.class;

	        	document.getElementById("imagen").src = data.image;

	        	var myLatLng = {lat: parseFloat(data.x), lng: parseFloat(data.y)};

	        	globalMap.setCenter(myLatLng);

	        	var marker = new google.maps.Marker({
	                map: globalMap,
	                position: myLatLng
	            });
	            markers.push(marker);

	        } else {
	        	alert("Error al cargar los datos");
	        }
	    }, "json");
	}
});

function initMap() {
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 12,
        center: {lat: -34.397, lng: 150.644}
    });
    globalMap = map;
}