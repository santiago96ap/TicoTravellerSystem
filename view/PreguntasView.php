<?php
include_once 'public/header.php';
?>

<div class="banner-inner">
</div>
<ol class="breadcrumb">
    <li class="breadcrumb-item">
        <a href="?Controller=Index&action=index">Home</a>
    </li>
    <li class="breadcrumb-item active">Recomendación de Sitios turísticos</li>
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

<!--PREGUNTA 1-->
<section id="p1" class="services">
    <div class="container">
        <h3 class="tittle_w3ls">Lugar de Preferencia</h3>
        <div class="row inner-sec-w3layouts-agileinfo">

            <div class="col-md-4 proj_gallery_grid" data-aos="zoom-in">
                <div class="section_1_gallery_grid">
                    <a title="Rural" href="public/images/p1Rural.jpg">
                        <div class="section_1_gallery_grid1">
                            <img src="public/images/p1Rural.jpg" alt=" " class="img-responsive" />
                            <div class="proj_gallery_grid1_pos">
                                <h3>Opción 1</h3>
                                <p>Rural</p>
                            </div>
                        </div>
                    </a>
                </div>

            </div>
            <div class="col-md-4 proj_gallery_grid" data-aos="zoom-in">
                <div class="section_1_gallery_grid" data-aos="zoom-in">
                </div>
            </div>
            <div class="col-md-4 proj_gallery_grid" data-aos="zoom-in">
                <div class="section_1_gallery_grid" data-aos="zoom-in">
                    <a title="Urbano" href="public/images/p1Urbano.png">
                        <div class="section_1_gallery_grid1">
                            <img src="public/images/p1Urbano.png" alt=" " class="img-responsive" />
                            <div class="proj_gallery_grid1_pos">
                                <h3>Opción 2</h3>
                                <p>Urbano</p>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label for="sel1">De las ilustraciones anteriores. ¿Cúal prefiere?</label>
            <select class="form-control" id="ps1">
                <option selected="selected" value="r">Rural</option>
                <option value="u">Urbano</option>
            </select>
        </div>


    </div>
</section>
<!--PREGUNTA 2-->
<section id="p2" class="services" style="display: none;">
    <div class="container">
        <h3 class="tittle_w3ls">Tipo de destino</h3>
        <div class="row inner-sec-w3layouts-agileinfo">

            <div class="col-md-4 proj_gallery_grid" data-aos="zoom-in">


            </div>
            <div class="col-md-4 proj_gallery_grid" data-aos="zoom-in">
                <div class="section_1_gallery_grid">
                    <a title="Rural" href="public/images/p2Dinero.png">
                        <div class="section_1_gallery_grid1">
                            <img src="public/images/p2Dinero.png" alt=" " class="img-responsive" />
                            <div class="proj_gallery_grid1_pos">
                                <h3>Tipo de destipo</h3>
                                <p>Monetario</p>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-md-4 proj_gallery_grid" data-aos="zoom-in">

            </div>
        </div>

        <div class="form-group">
            <label for="sel1">¿Cúal el tipo de destino que  prefiere?</label>
            <select class="form-control" id="ps2">
                <option selected="selected" value="e">Económico</option>
                <option value="i">Intermedio</option>                
                <option value="c">Costoso</option>

            </select>
        </div>
    </div>
</section>
<!--PREGUNTA 3-->
<section id="p3" class="services" style="display: none;">
    <div class="container">
        <h3 class="tittle_w3ls">Tipo de destino</h3>
        <div class="row inner-sec-w3layouts-agileinfo">

            <div class="col-md-4 proj_gallery_grid" data-aos="zoom-in">
                <div class="section_1_gallery_grid">
                    <a title="Rural" href="public/images/p3Playa.jpg">
                        <div class="section_1_gallery_grid1">
                            <img src="public/images/p3Playa.jpg" alt=" " class="img-responsive" />
                            <div class="proj_gallery_grid1_pos">
                                <h3>Tipo de destipo</h3>
                                <p>Playa</p>
                            </div>
                        </div>
                    </a>
                </div>


            </div>
            <div class="col-md-4 proj_gallery_grid" data-aos="zoom-in">
                <div class="section_1_gallery_grid">
                    <a title="Rural" href="public/images/p3Bosque.png">
                        <div class="section_1_gallery_grid1">
                            <img src="public/images/p3Bosque.png" alt=" " class="img-responsive" />
                            <div class="proj_gallery_grid1_pos">
                                <h3>Tipo de destipo</h3>
                                <p>Montaña</p>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-md-4 proj_gallery_grid" data-aos="zoom-in">
                <div class="section_1_gallery_grid">
                    <a title="Rural" href="public/images/p3Pool.jpg">
                        <div class="section_1_gallery_grid1">
                            <img src="public/images/p3Pool.jpg" alt=" " class="img-responsive" />
                            <div class="proj_gallery_grid1_pos">
                                <h3>Tipo de destipo</h3>
                                <p>Centro turístico</p>
                            </div>
                        </div>
                    </a>
                </div>

            </div>
        </div>

        <div class="form-group">
            <label for="sel1">¿Cúal el tipo de destino que  prefiere?</label>
            <select class="form-control" id="ps3">
                <option selected="selected" value="y">Playa</option>
                <option value="b">Montaña</option>                
            </select>
        </div>
    </div>
</section>
<!--PREGUNTA 4-->
<section id="p4" class="services" style="display: none;">
    <div class="container">
        <h3 class="tittle_w3ls">Tiempo</h3>
        <div class="row inner-sec-w3layouts-agileinfo">

            <div class="col-md-4 proj_gallery_grid" data-aos="zoom-in">


            </div>
            <div class="col-md-4 proj_gallery_grid" data-aos="zoom-in">
                <div class="section_1_gallery_grid">
                    <a title="Rural" href="public/images/p4Tiempo.png">
                        <div class="section_1_gallery_grid1">
                            <img src="public/images/p4Tiempo.png" alt=" " class="img-responsive" />
                            <div class="proj_gallery_grid1_pos">
                                <h3>Duración</h3>
                                <p>tiempo</p>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-md-4 proj_gallery_grid" data-aos="zoom-in">

            </div>
        </div>

        <div class="form-group">
            <label for="sel1">¿Cuánto tiempor tiene pensado durar en el viaje?</label>
            <select class="form-control" id="ps4">
                <option selected="selected" value="a">Menos de una hora</option>
                <option value="b">1-2 horas</option>                
                <option value="c">3-más horas</option>

            </select>
        </div>
    </div>
</section>
<!--PREGUNTA 5-->
<section id="p5" class="services" style="display: none;">
    <div class="container">
        <h3 class="tittle_w3ls">Tipo camino</h3>
        <div class="row inner-sec-w3layouts-agileinfo">

            <div class="col-md-4 proj_gallery_grid" data-aos="zoom-in">
                <div class="section_1_gallery_grid">
                    <a title="Asfalto" href="public/images/p5As.jpg">
                        <div class="section_1_gallery_grid1">
                            <img src="public/images/p5As.jpg" alt=" " class="img-responsive" />
                            <div class="proj_gallery_grid1_pos">
                                <h3>Opción 1</h3>
                                <p>Asfalto</p>
                            </div>
                        </div>
                    </a>
                </div>

            </div>
            <div class="col-md-4 proj_gallery_grid" data-aos="zoom-in">
                <div class="section_1_gallery_grid" data-aos="zoom-in">
                </div>
            </div>
            <div class="col-md-4 proj_gallery_grid" data-aos="zoom-in">
                <div class="section_1_gallery_grid" data-aos="zoom-in">
                    <a title="Lastre" href="public/images/p5T.jpg">
                        <div class="section_1_gallery_grid1">
                            <img src="public/images/p5T.jpg" alt=" " class="img-responsive" />
                            <div class="proj_gallery_grid1_pos">
                                <h3>Opción 2</h3>
                                <p>Lastre</p>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label for="sel1">De las ilustraciones anteriores. ¿Cúal prefiere?</label>
            <select class="form-control" id="ps5">
                <option selected="selected" value="v">Asfalto</option>
                <option value="p">Lastre</option>
            </select>
        </div>

        <button type="submit" class="btn btn-info" onclick="enviarDatosRecomendacion();">Finalizar</button>
    </div>
</section>

<div class="container">

        <ul class="pagination">
            <li class="page-item"><a class="page-link" onclick="cambiarOpcion('1');">1</a></li>
            <li class="page-item"><a class="page-link" onclick="cambiarOpcion('2');">2</a></li>
            <li class="page-item"><a class="page-link" onclick="cambiarOpcion('3');">3</a></li>            
            <li class="page-item"><a class="page-link" onclick="cambiarOpcion('4');">4</a></li>
            <li class="page-item"><a class="page-link" onclick="cambiarOpcion('5');">5</a></li>
        </ul>


</div> 
 <script src="public/js/jquery-3.2.1.min.js" type="text/javascript"></script>
<script src="public/js/view/PreguntaView.js" type="text/javascript"></script> 

<?php
include_once 'public/footer.php';
?>


