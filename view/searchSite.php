<?php
include_once 'public/header.php';
?>

<div class="banner-inner">
</div>
<ol class="breadcrumb">
    <li class="breadcrumb-item">
        <a href="?Controller=Index&action=index">Home</a>
    </li>
    <li class="breadcrumb-item active">Buscar Sitio Turistico</li>
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
        <h3 class="tittle_w3ls">Sitios Turisticos</h3>
        <div class="contact_grid_right">
            <label for="sel1">Selecciona el sitio turistico</label>
            <form>
                <div class="contact_left_grid">
                    <input type="text" id="nSitio" placeholder="Nombre de Usuario" required="">
                    <button type="button" class="btn btn-info" id="search">Buscar</button>
                    <div class="clearfix"> </div>
                </div>
            </form>
        </div>
    </div>
</section>

<section class="services" id="result" style="display: none;">
    <div class="container">
        <h4 class="tittle_w3ls" id="nombreSitio"></h4>
        <div class="row inner-sec-w3layouts-agileinfo">
            <button id="btnSitio" class="btn btn-info" data-toggle="modal" data-target="#modalSite1">Acerca de</button>
        </div>
    </div>
</section>
<div id="map" style="display: none;"></div>


<!-- Modal Sitio 1 -->
<div class="modal fade" id="modalSite1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="nombreSitio"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <h2 class="font-weight-bold text-center" id="nombreSitioModal"></h2>
        <h6 class="font-italic text-center" id="direccionSitioModal"></h6>
        <p class="font-weight-light text-justify" id="descripcionSitioModal"></p>
        <center>
            <button id="videoSitio1" type="button" class="btn btn-outline-info ">Video</button>
        </center>
        
            <div class="row inner-sec-w3layouts-agileinfo">
            <div class="col-md-4 proj_gallery_grid" data-aos="zoom-in"></div>
            <div class="col-md-4 proj_gallery_grid" data-aos="zoom-in">
                <div class="section_1_gallery_grid">
                    <a  id="img1" title="Imagen del sitio" href="">
                        <div class="section_1_gallery_grid1">
                            <img id="imgSitio1" src="public/images/p4Tiempo.png" alt=" " class="img-responsive" />
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-md-4 proj_gallery_grid" data-aos="zoom-in"></div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<?php
include_once 'public/footer.php';
?>

 <script src="public/js/jquery-3.2.1.min.js" type="text/javascript"></script>
  <script async defer
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC1JuYmoq83Om5mLz0qyg_k1viClteC2NU&callback=initMap"></script>
</script>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script >
       $( function() {
    $( "#nSitio" ).autocomplete({
      source: arraySitios
    });
  } );
  </script>
<script src="public/js/view/SearchView.js" type="text/javascript"></script> 

  


