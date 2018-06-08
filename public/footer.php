<footer>
	<div class="copyright">
		<div class="container">
			<div class="copyrighttop" data-aos="fade-left">
				<ul>
					<li>
						<h4>Siguenos en:</h4>
					</li>
					<li>
						<a class="facebook" href="#">
							<i class="fab fa-facebook-f"></i>
						</a>
					</li>
					<li>
						<a class="facebook" href="#">
							<i class="fab fa-twitter"></i>
						</a>
					</li>
					<li>
						<a class="facebook" href="#">
							<i class="fab fa-google-plus-g"></i>
						</a>
					</li>
					<li>
						<a class="facebook" href="#">
							<i class="fab fa-pinterest-p"></i>
						</a>
					</li>
				</ul>
			</div>
			<div class="copyrightbottom" data-aos="fade-right">
				<p>© 2018 Tico Traveller. Todos los derechos reservados | Design by
					<a href="http://w3layouts.com/">W3layouts</a>
				</p>

			</div>
			<div class="clearfix"></div>
		</div>
	</div>
    </footer>
	<!-- js -->
	<script type="text/javascript" src="public/js/jquery-2.2.3.min.js"></script>
	<!-- //js -->
	<!-- simpleLightbox -->
	<script src="public/js/simpleLightbox.js"></script>
	<script>
		$('.proj_gallery_grid a').simpleLightbox();
	</script>
	<!-- //simpleLightbox -->
	<!-- flexSlider -->
	<script defer src="public/js/jquery.flexslider.js"></script>
	<script type="text/javascript">
	 
	  $(window).load(function(){
		$('.flexslider').flexslider({
		  animation: "slide",
		  start: function(slider){
			$('body').removeClass('loading');
		  }
		});
	  });
	</script>
  
	<!-- //flexSlider -->

	<!-- stats -->
	<script src="public/js/jquery.waypoints.min.js"></script>
	<script src="public/js/jquery.countup.js"></script>
	<script>
		$('.counter').countUp();
	</script>
	<!-- //stats -->
	<!-- /js files -->
	<link href='public/css/aos.css' rel='stylesheet prefetch' type="text/css" media="all" />
	<link href='public/css/aos-animation.css' rel='stylesheet prefetch' type="text/css" media="all" />
	<script src='public/js/aos.js'></script>
	<script src="public/js/aosindex.js"></script>
	<!-- //js files -->
	<!-- start-smoth-scrolling -->
	<script type="text/javascript" src="public/js/move-top.js"></script>
	<script type="text/javascript" src="public/js/easing.js"></script>
	<script type="text/javascript">
		jQuery(document).ready(function ($) {
			$(".scroll").click(function (event) {
				event.preventDefault();
				$('html,body').animate({
					scrollTop: $(this.hash).offset().top
				}, 900);
			});
		});
	</script>
	<!-- start-smoth-scrolling -->

	<script type="text/javascript">
		$(document).ready(function () {
			/*
									var defaults = {
							  			containerID: 'toTop', // fading element id
										containerHoverID: 'toTopHover', // fading element hover id
										scrollSpeed: 1200,
										easingType: 'linear' 
							 		};
									*/

			$().UItoTop({
				easingType: 'easeOutQuart'
			});

		});
	</script>
	<a href="#home" class="scroll" id="toTop" style="display: block;">
		<span id="toTopHover" style="opacity: 1;"> </span>
	</a>
	<script type="text/javascript" src="public/js/bootstrap.min.js"></script>


</body>

</html>