<?php
include_once 'public/header.php';
?>
<div class="banner-inner">
</div>
<ol class="breadcrumb">
    <li class="breadcrumb-item">
        <a href="?Controller=Index&action=indexADM">Inicio</a>
    </li>
    <li class="breadcrumb-item active">Registar Sitio</li>
</ol>
<section>
    <div class="container">

        <div class="col-8">
            <h2>Actualizar o eleminar Sitios turísticos</h2><br>

            <form>
                <div class="form-group">
                    <label for="exampleFormControlSelect1">Sitio Turístico</label>
                    <select class="form-control" id="exampleFormControlSelect1">
                        <option>Sitio 1</option>
                        <option>Lastre</option>
                    </select>
                </div>
                <div class="form-group">
                    <input placeholder="Nombre..." type="text" class="form-control" id="nombre">
                </div>
                <div class="form-group">
                    <input placeholder="Dirección..." type="text" class="form-control" id="direccion">
                </div>
                <div class="form-group form-check">
                    <input placeholder="Descripción..." type="text" class="form-control" id="desc">
                </div>

                <div class="form-group form-check">
                    <input placeholder="Cordena X..." type="number" class="form-control" id="x">
                </div>
                <div class="form-group form-check">
                    <input placeholder="Cordena Y..." type="number" class="form-control" id="y">
                </div>
                <div class="form-group">
                    <label for="exampleFormControlSelect1">Tipo de precio</label>
                    <select class="form-control" id="exampleFormControlSelect1">
                        <option>Económico</option>
                        <option>Intermedio</option>
                        <option>Costoso</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="exampleFormControlSelect1">Lugar de preferencia</label>
                    <select class="form-control" id="exampleFormControlSelect1">
                        <option>Rural</option>
                        <option>Urbano</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="exampleFormControlSelect1">Tipo de destino</label>
                    <select class="form-control" id="exampleFormControlSelect1">
                        <option>Playa</option>
                        <option>Montaña</option>
                        <option>Centro turístico</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="exampleFormControlSelect1">Tiempo</label>
                    <select class="form-control" id="exampleFormControlSelect1">
                        <option>-1 hora</option>
                        <option>1-2 horas</option>
                        <option>3 o más</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="exampleFormControlSelect1">Tipo de camino</label>
                    <select class="form-control" id="exampleFormControlSelect1">
                        <option>Pavimento</option>
                        <option>Lastre</option>
                    </select>
                </div>

                <div class="input-group">
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" id="inputGroupFile04">
                        <label class="custom-file-label" for="inputGroupFile04">Elegir un archivo</label>
                    </div>
                </div>


                <button type="submit" class="btn btn-warning">Actualizar</button>
                <button type="submit" class="btn btn-danger">Eliminar</button>
            </form>
        </div>
    </div>
</section>
<?php
include_once 'public/footer.php';
?>	