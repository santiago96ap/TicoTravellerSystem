<!DOCTYPE html>
<html>

    <head>
        <title>Tico Traveller</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta charset="utf-8">
        <meta name="keywords" content="Tico Traveller" />
        <meta http-equiv="Expires" content="0">
        <meta http-equiv="Last-Modified" content="0">
        <meta http-equiv="Cache-Control" content="no-cache, mustrevalidate">
        <meta http-equiv="Pragma" content="no-cache">
        <link rel="shortcut icon" type="image/x-icon" href="images/logo.png" />

        <script type="application/x-javascript">
            addEventListener("load", function () {
            setTimeout(hideURLbar, 0);
            }, false);

            function hideURLbar() {
            window.scrollTo(0, 1);
            }
        </script>
        <script src="public/js/jquery-3.2.1.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
        <link href="public/css/bootstrap.css" rel='stylesheet' type='text/css' />
        <link rel="stylesheet" href="public/css/flexslider.css" type="text/css" media="screen" property="" />
        <link href="public/css/style.css" rel='stylesheet' type='text/css' />
        <link href="public/css/simpleLightbox.css" rel='stylesheet' type='text/css' />
        <link href="public/css/fontawesome-all.css" rel="stylesheet">
        <link href="public/css/contact.css" rel='stylesheet' type='text/css' />
        <link href="public/css/team.css" rel='stylesheet' type='text/css' />
       
        
        <link href="//fonts.googleapis.com/css?family=Poppins:100i,200,200i,300,400,400i,500,500i,600,600i,700,700i,800" rel="stylesheet">

        <style>
              html, body {
                height: 100%;
                margin: 0;
                padding: 0;
              }
              #map {
                height: 20%;
                float: center;
                width: 60%;
                height: 50%;
                margin-left: 100px;
                margin-bottom: 10px;
              }
                        #map1 {
                height: 20%;
                float: center;
                width: 60%;
                height: 50%;
                margin-left: 100px;
                margin-bottom: 10px;
              }
                        #map2 {
                height: 20%;
                float: center;
                width: 60%;
                height: 50%;
                margin-left: 100px;
                margin-bottom: 10px;
              }          #map3 {
                height: 20%;
                float: center;
                width: 60%;
                height: 50%;
                margin-left: 100px;
                margin-bottom: 10px;
              }
              .images-container {
                  width: 90%;
                  text-align: center;
                  margin: 60px auto 60px;
                }
                .container-enlarge {
                    display: inline-block;
                    position: relative;
                    z-index: 0;
                    margin: 15px;
                }
                .container-enlarge > img {
                    height: auto;
                    max-width: 100%;
                    width: 150px;
                    border-radius: 5px;
                }
                .container-enlarge span {
                    position: absolute;
                    top: -9999em;
                    left: -9999em;
                }
                .container-enlarge:hover span {
                    top: -320px;
                    left: -75px;
                    width: 300px;
                }

    </style>
    </head>

    <body>
        <header>
            <div class="header_top" id="home">
                <nav class="navbar navbar-toggleable-md navbar-light bg-faded">
                    <a class="navbar-brand" href="?controller=Index&action=defaultAction">
                        <i class="fab fa-digital-ocean"></i> Tico Traveller</a>
                    <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                            aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav mx-auto tp-nav text-center">
                            <li class="nav-item active">
                                <a class="nav-link" href="?controller=Index&action=defaultAction">Inicio
                                    <span class="sr-only">(current)</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="?controller=Index&action=preguntas">Recomendación</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="?controller=Index&action=contactenos">Contáctenos
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="?controller=Index&action=dondeEncontrar">¿Dónde encontrarnos?</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="?controller=Index&action=sitioInteres">Sitios de interés</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="?controller=Index&action=sobreNosotros">Sobre nosotros</a>
                            </li>

                            <li class="nav-item">
                                <a class="nav-link" href="?controller=Index&action=login">login</a>
                            </li>
                        </ul>
                    </div>
                </nav>
            </div>
        </header>
        <!--//header-->