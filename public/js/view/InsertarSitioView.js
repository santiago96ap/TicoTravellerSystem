

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
        url: "?controller=Site&action=insertSite",
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