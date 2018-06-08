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
        <h2>Sitios Turísticos registtados en el sistema</h2>
        <p>A continuación, se le presentan los sitios turísticos que se han registrado previamente en el sistema.</p>
        <table class="table">
            <thead>
                <tr>
                    <th>Nombre</th>
                    <th>Dirección</th>
                    <th>Descripción</th>                    
                    <th>Tipo precio</th>
                    <th>Zona</th>
                    <th>Tipo de destino</th>
                    <th>Duración</th>
                    <th>Camino</th>
                </tr>
            </thead>
            <tbody>    
                <tr class="table-primary">
                    <td>Default</td>
                    <td>Defaultson</td>
                    <td>Default</td>
                    <td>Default</td>
                    <td>Default</td>
                    <td>Default</td>
                    <td>Default</td>
                    <td>Default</td>
                </tr>
                <tr class="table-success">
                   <td>Default</td>
                    <td>Defaultson</td>
                    <td>Default</td>
                    <td>Default</td>
                    <td>Default</td>
                    <td>Default</td>
                    <td>Default</td>
                    <td>Default</td>
                </tr>
                <tr class="table-danger">
                     <td>Default</td>
                    <td>Defaultson</td>
                    <td>Default</td>
                    <td>Default</td>
                    <td>Default</td>
                    <td>Default</td>
                    <td>Default</td>
                    <td>Default</td>
                </tr>
                <tr class="table-info">
                    <td>Default</td>
                    <td>Defaultson</td>
                    <td>Default</td>
                    <td>Default</td>
                    <td>Default</td>
                    <td>Default</td>
                    <td>Default</td>
                    <td>Default</td>
                </tr>
                <tr class="table-warning">
                     <td>Default</td>
                    <td>Defaultson</td>
                    <td>Default</td>
                    <td>Default</td>
                    <td>Default</td>
                    <td>Default</td>
                    <td>Default</td>
                    <td>Default</td>
                </tr>
            </tbody>
        </table>
    </div>


</section>

<?php
include_once 'public/footer.php';
?>
