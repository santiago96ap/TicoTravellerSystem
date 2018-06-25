<?php
include_once 'public/header.php';
?>	
<div class="banner-inner">
</div>
<ol class="breadcrumb">
    <li class="breadcrumb-item">
        <a href="index.html">Inicio</a>
    </li>
    <li class="breadcrumb-item active">Iniciar Sesión</li>
</ol>
<!--/model-->
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Introduction Video</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body video">
                <iframe src="https://player.vimeo.com/video/33531612"></iframe>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>
<!--//model-->

<section class="services">
    <div class="container">

        <div class="contact_grid_right">
            <h6>Iniciar Sesión</h6>
            <form>
                <div class="form-group">
                    <input placeholder="Nombre..." type="text" class="form-control" id="nombre">
                </div>
                <div class="form-group">
                    <input placeholder="Direcci&oacute;n..." type="text" class="form-control" id="direccion">
                </div>
                <div class="form-group form-check">
                    <input placeholder="Descripci&oacute;n..." type="text" class="form-control" id="descripcion">
                </div>

                <div class="form-group form-check">
                    <input placeholder="Cordena X..." type="text" class="form-control" id="x">
                </div>
                <div class="form-group form-check">
                    <input placeholder="Cordena Y..." type="text" class="form-control" id="y">
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
                        <option value="" data-tokens="">Paradero</option>
                        <option value="" data-tokens="">Restaurante</option>
                    </select>
                </div>

                <div class="input-group">
                    <div class="custom-file">
<!--                          <input type="file" class="custom-file-input" id="myfile" name="myfile" size="30">
                        <label class="custom-file-label" for="inputGroupFile04">Elegir una im&aacute;gen</label> -->
                    </div>
                </div>
                <input type="submit" id="send-info" value="Ingresar"/>
            </form>
        </div>
    </div>
</section>

<?php
include_once 'public/footer.php';
?>	