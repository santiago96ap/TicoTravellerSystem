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
                <div class="contact_left_grid">
                    <input type="email" name="userName" id="userName" placeholder="Correo electrónico" required="">
                    <input type="text" name="pass" id="pass" placeholder="contraseña" required=""><br><br>
                    <input type="button" class="btn btn-primary" id="send-info" value="Ingresar"/>
                    <div class="clearfix"> </div>
                </div>
            </form>
        </div>
    </div>
</section>

<script src="public/js/jquery-3.2.1.min.js" type="text/javascript"></script>
<script src="public/js/view/SessionView.js" type="text/javascript"></script>

<?php
include_once 'public/footer.php';
?>	


