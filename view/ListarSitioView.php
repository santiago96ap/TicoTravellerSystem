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
<section>
    <div class="container">

        <div class="col-8">
            <h2>Listar Sitios tur&iacute;sticos</h2><br>

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
                    <label for="exampleFormControlSelect1">Nombre</label>
                    <input placeholder="Nombre..." type="text" class="form-control" id="nombre" readonly>
                </div>
                <div class="form-group">
                    <label for="exampleFormControlSelect1">Direcci&oacute;n</label>
                    <input placeholder="Direcci&oacute;n..." type="text" class="form-control" id="direccion" readonly>
                </div>
                <div class="form-group form-check">
                    <label for="exampleFormControlSelect1">Descripci&oacute;n</label>
                    <input placeholder="Descripci&oacute;n..." type="text" class="form-control" id="descripcion" readonly>
                </div>

                <div class="form-group form-check">
                    <label for="exampleFormControlSelect1">X</label>
                    <input placeholder="Cordena X..." type="text" class="form-control" id="x" readonly>
                </div>
                <div class="form-group form-check">
                    <label for="exampleFormControlSelect1">Y</label>
                    <input placeholder="Cordena Y..." type="text" class="form-control" id="y" readonly>
                </div>
                <div class="form-group">
                    <label for="exampleFormControlSelect1">Tipo de precio</label>
                    <input placeholder="Tipo de precio..." type="text" class="form-control" id="tipoPrecio" readonly>
                </div>
                <div class="form-group">
                    <label for="exampleFormControlSelect1">Lugar de preferencia</label>
                    <input placeholder="Lugar de preferencia..." type="text" class="form-control" id="lugarPreferencia" readonly>
                </div>
                <div class="form-group">
                    <label for="exampleFormControlSelect1">Tipo de destino</label>
                    <input placeholder="Tipo de destino..." type="text" class="form-control" id="tipoDestino" readonly>
                </div>
                <div class="form-group">
                    <label for="exampleFormControlSelect1">Tiempo</label>
                    <input placeholder="Tiempo..." type="text" class="form-control" id="tiempo" readonly>
                </div>
                <div class="form-group">
                    <label for="exampleFormControlSelect1">Tipo de camino</label>
                    <input placeholder="Tipo de camino..." type="text" class="form-control" id="tipoCamino" readonly>
                </div>

                <div class="form-group">
                    <label for="exampleFormControlSelect1">Categoria</label>
                    <input placeholder="Categoria..." type="text" class="form-control" id="categoria" readonly>
                </div>

                <div class="form-group">
                    <label for="exampleFormControlSelect1">Im&aacute;gen del sitio</label>
                    <img src="public/images/logo.png" id="imagen" height="100" width="100">
                </div>

                <div class="form-group">
                    <label for="exampleFormControlSelect1">Ubicaci&oacute;n del sitio</label>
                </div>

            </form>
        </div>
    </div>
</section>

<div id="map"></div>

 <script src="public/js/jquery-3.2.1.min.js" type="text/javascript"></script>
<script async defer
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC1JuYmoq83Om5mLz0qyg_k1viClteC2NU&callback=initMap"></script>
</script>
<script src="public/js/view/ListarSitioView.js" type="text/javascript"></script> 

<?php
include_once 'public/footer.php';
?>  