<?php
include_once 'public/header.php';
?>

<!--/banner-->
	<div class="banner">
		<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
				<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
				<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner" role="listbox">
				<div class="carousel-item active">
					<div class="carousel-caption">
						<h3>¡Bienvenido a Tico Trevaller!</h3>

					</div>
				</div>
				<div class="carousel-item item2">
					<div class="carousel-caption">
						<h3>Te recomendamos sitios turístico</h3>
					</div>
				</div>
				<div class="carousel-item item3">
					<div class="carousel-caption">
						<h3>¡Visitanos!</h3>
					</div>
				</div>
			</div>
			<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a>
			<a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
		</div>
	</div>
	<!--/model-->
	<!-- /stats -->
	<section class="stats_test container-fluid">
		<div class="row inner_stat_wthree_agileits">
			<div class="col-md-3 stats_left counter_grid">
				<i class="far fa-building"></i>
				<p class="counter">+50</p>
				<h4>Sitios turísticos</h4>
			</div>
			<div class="col-md-3 stats_left counter_grid1">
				<i class="fas fa-users"></i>
				<p class="counter">+100</p>
				<h4>Visitas</h4>
			</div>
			<div class="col-md-3 stats_left counter_grid2">
				<i class="far fa-edit"></i>
				<p class="counter">+100</p>
				<h4>Comentarios</h4>
			</div>
			<div class="col-md-3 stats_left counter_grid3">
				<i class="far fa-smile"></i>
				<p class="counter">+100</p>
				<h4>Happy Clients</h4>
			</div>

		</div>
		</div>
	</section>
	<!-- //stats -->
<?php
include_once 'public/footer.php';
?>