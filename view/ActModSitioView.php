<?php
include_once 'public/header.php';
?>
<div class="banner-inner">
</div>
<ol class="breadcrumb">
    <li class="breadcrumb-item">
        <a href="?controller=Index&action=indexADM">Inicio</a>
    </li>
    <li class="breadcrumb-item active">Actualizar o eleminar Sitios tur&iacute;sticos</li>
</ol>
<section>
    <div class="container">

        <div class="col-8">
            <h2>Actualizar o eleminar Sitios tur&iacute;sticos</h2><br>

            <form>

                <div class="form-group">
                    <label for="exampleFormControlSelect1">Sitios Tur&iacute;stico</label>
                    <select class="form-control" id="allSites">
                    <option value="-1" data-tokens="">Seleccione un Sitio</option>
                        <?php
                        foreach ($vars as $var) {
                            if (isset($var["id"])) {
                                ?>
                                <option value="<?php echo $var["id"] ?> " data-tokens="">
                                    <?php echo $var["name"] ?>
                                </option>
                                <?php
                            }
                        }
                        ?>
                    </select>
                </div>

                <div class="form-group">
                    <input placeholder="Nombre..." type="text" class="form-control" id="nombre">
                </div>
                <div class="form-group">
                    <input placeholder="Direcci&oacute;n..." type="text" class="form-control" id="direccion">
                </div>
                <div class="form-group form-check">
                    <input placeholder="Descripci&oacute;n..." type="text" class="form-control" id="descripcion">
                </div>

                <div class="form-group">
                    <label for="exampleFormControlSelect1">Tipo de precio</label>
                    <select class="form-control" id="tipoPrecio">
                        <option value="e" data-tokens="">Econ&oacute;mico</option>
                        <option value="i" data-tokens="">Intermedio</option>
                        <option value="c" data-tokens="">Costoso</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="exampleFormControlSelect1">Lugar de preferencia</label>
                    <select class="form-control" id="lugarPreferencia">
                        <option value="r" data-tokens="">Rural</option>
                        <option value="u" data-tokens="">Urbano</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="exampleFormControlSelect1">Tipo de destino</label>
                    <select class="form-control" id="tipoDestino">
                        <option value="y" data-tokens="">Playa</option>
                        <option value="b" data-tokens="">Bosque</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="exampleFormControlSelect1">Tiempo</label>
                    <select class="form-control" id="tiempo">
                        <option value="a" data-tokens="">Menos de hora</option>
                        <option value="b" data-tokens="">Entre 1-2 horas</option>
                        <option value="c" data-tokens="">M&aacute;s de 3 horas</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="exampleFormControlSelect1">Tipo de camino</label>
                    <select class="form-control" id="tipoCamino">
                        <option value="v" data-tokens="">Pavimento</option>
                        <option value="p" data-tokens="">Lastre</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="exampleFormControlSelect1">Categoria</label>
                    <select class="form-control" id="categoria">
                        <option value="natural" data-tokens="">Natural</option>
                        <option value="hotel" data-tokens="">Hotel</option>
                        <option value="paradero" data-tokens="">Paradero</option>
                        <option value="restaurante" data-tokens="">Restaurante</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="exampleFormControlSelect1">Im&aacute;gen del sitio</label>
                </div>

                <div class="form-group">
                    <img src="public/images/logo.png" id="imagen" height="250" width="250">
                </div>

                <div class="form-group">
                    <label for="exampleFormControlSelect1">Cambiar im&aacute;gen</label>
                </div>

                <div class="form-group">
                    <input type="file" id="myfile" name="myfile" size="30">
                </div>

                <div class="form-group">
                    <input placeholder="Cambiar Ubicaci&oacute;n..." type="text" class="form-control" id="ubicacion">
                </div>

                <div class="form-group">
                    <input type="button" class="btn btn-primary" id="send-info-buscar" value="Buscar"/>
                </div>

                <div class="form-group form-check">
                    <input placeholder="Cordena X..." type="text" class="form-control" id="x" readonly="">
                </div>
                <div class="form-group form-check">
                    <input placeholder="Cordena Y..." type="text" class="form-control" id="y" readonly="">
                </div>
            </form>
        </div>
    </div>
</section>

<div id="map"></div>

<section>
    <div class="container">

        <div class="col-8">
            <form>
                <div class="form-group">
                     <button type="button" id="send-info-update" class="btn btn-warning">Actualizar</button>
                    <button type="button" id="send-info-delete" class="btn btn-danger">Eliminar</button>
                </div>
            </form>
        </div>
    </div>
</section>

 <script src="public/js/jquery-3.2.1.min.js" type="text/javascript"></script>
  <script async defer
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC1JuYmoq83Om5mLz0qyg_k1viClteC2NU&callback=initMap"></script>
</script>
<script src="public/js/view/ActModSitioView.js" type="text/javascript"></script> 

<?php
include_once 'public/footer.php';
?>	