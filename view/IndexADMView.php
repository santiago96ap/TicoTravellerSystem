<?php
include_once 'public/header.php';
?>
<div class="banner-inner">
</div>
<ol class="breadcrumb">
    <li class="breadcrumb-item">
        <a href="?Controller=Index&action=indexADM">Home</a>
    </li>
    <li class="breadcrumb-item active">Inicio Admnistrador</li>
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


        <h2>Opciones para administrar los sitios turísticos</h2>   <br>
        <div class="list-group">
            <a href="?controller=Index&action=registrarSitio" class="list-group-item list-group-item-action list-group-item-success">Registrar sitios turísticos</a>
            <a href="?controller=Index&action=actModSitio" class="list-group-item list-group-item-action list-group-item-warning">Actualizar o eliminar sitios turísticos</a>
            <a href="?controller=Index&action=listarSitio" class="list-group-item list-group-item-action list-group-item-info">Listar sitios turísticos</a>
        </div>
        <br>
    </div>


</section>

<?php
include_once 'public/footer.php';
?>
