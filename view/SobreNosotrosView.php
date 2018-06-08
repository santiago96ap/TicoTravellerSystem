<?php
include_once 'public/header.php';
?>
<div class="banner-inner">
</div>
<ol class="breadcrumb">
    <li class="breadcrumb-item">
        <a href="index.html">Inicio</a>
    </li>
    <li class="breadcrumb-item active">Sobre Nosostros</li>
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

<section class="banner-bottom">
    <div class="container marketing">

        <!-- Three columns of text below the carousel -->
        <div class="row inner-sec-w3layouts-agileinfo">
            <div class="col-lg-4 bottom-sub-grid text-center" data-aos="zoom-in">
                <div class="bt-icon">

                    <span class="fas fa-trophy"></span>
                </div>

                <h4 class="sub-tittle_w3ls">Equipo de trabajo</h4>
                <p class="text-justify">Con profesionales de gran calidad en distintas tecnologías</p>
            </div>
            <!-- /.col-lg-4 -->
            <div class="col-lg-4 bottom-sub-grid text-center" data-aos="zoom-in">
                <div class="bt-icon">
                    <span class="far fa-thumbs-up"></span>
                </div>

                <h4 class="sub-tittle_w3ls">Sobre nosotros</h4>
                <p class="text-justify">Somos tres desarrolladores de software con el fin  hacer la experiencia del usuario más agradable y fácil con el propósito propósito de recomendar sitios turísticos que se encuentran cercanos según las características proporcionadas por el usuario</p>
            </div>
            <!-- /.col-lg-4 -->
            <div class="col-lg-4 bottom-sub-grid text-center" data-aos="zoom-in">
                <div class="bt-icon">
                    <span class="fas fa-tv"></span>
                </div>

                <h4 class="sub-tittle_w3ls">Desarrollo de Software</h4>
                <p class="text-justify">Líderes en cualquier tipo de aplicación</p>
            </div>
            <!-- /.col-lg-4 -->
        </div>

    </div>
    <!-- /.row -->
</div>
</section>
<!--//model-->

<section class="services">
    <div class="container">

        <div class="contact_grid_right">
            <h6>´Sugerencias</h6>
            <form action="#" method="post">
                <div class="contact_left_grid">
                    <input type="text" name="Name" placeholder="Nombre" required="">
                    <input type="email" name="Email" placeholder="Correo electrónico" required="">
                    <input type="text" name="Subject" placeholder="Asunto" required="">
                    <textarea name="Message" onfocus="this.value = '';" onblur="if (this.value == '') {
                                this.value = 'Mensaje...';
                            }" required="">Mensaje...</textarea>
                    <input type="submit" value="Enviar">
                    <input type="reset" value="Limpiar">
                    <div class="clearfix"> </div>
                </div>
            </form>
        </div>
    </div>
</section>
<?php
include_once 'public/footer.php';
?>	