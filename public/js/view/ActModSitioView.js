

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

	        } else {
	        	alert("Error al cargar los datos");
	        }
	    }, "json");
	}
});

$("#send-info-delete").click(function () {

	if ($("#allSites").val() !== "-1") {

	    var datas = new FormData();
		datas.append('id', $("#allSites").val());
	    
	    $.ajax({
	        processData: false,
	        contentType: false,
	        cache: false,
	        data: datas,
	        url: "?controller=Admin&action=deleteSite",
	        type: 'post',
	        success: function (response) {
	            var data = JSON.parse(response);
	            if (data.result === '1') {
					alert("Solicitud ejecutada correctamente");
					setTimeout("location.href = '?controller=Index&action=indexADM';", 100);
	            } else {
	               alert("Solicitud ejecutada incorrectamente");
	               setTimeout("location.href = '?controller=Index&action=indexADM';", 100);
	            }
	        }
	    });
	}
});

$("#send-info-update").click(function () {

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
	datas.append('id', $("#allSites").val());
    
    $.ajax({
        processData: false,
        contentType: false,
        cache: false,
        data: datas,
        url: "?controller=Admin&action=updateSite",
        type: 'post',
        success: function (response) {
            var data = JSON.parse(response);
            if (data.result === '1') {
				alert("Solicitud ejecutada correctamente");
				setTimeout("location.href = '?controller=Index&action=indexADM';", 100);
            } else {
               alert("Solicitud ejecutada incorrectamente");
               setTimeout("location.href = '?controller=Index&action=indexADM';", 100);
            }
        }
    });
});