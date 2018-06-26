
$("#allSites").change(function () {

	if ($("#allSites").val() !== "-1") {

	    var parameters = {
	        "id": $("#allSites").val()
	    };

	    $.post("?controller=Admin&action=getInformationSite", parameters, function (data) {
	        if (data.id) {

	        	document.getElementById("nombre").value = data.name
	        	document.getElementById("direccion").value = data.address
	        	document.getElementById("descripcion").value = data.description

	        } else {
	        	alert("Error al cargar los datos");
	        }
	    }, "json");
	}
});