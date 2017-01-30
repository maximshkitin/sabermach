var createPopup = require('./components/popups.js');

jQuery(document).ready(function(){
	width = window.innerWidth;
	height = window.innerHeight;

	if ($('body').hasClass('home')) {
		
		if ( width <= 600 ) {
				require('./mobile.js');
		}

		if ( width >= 600 && width <= 800 ) {
			require('./tablet.js');
		}

		if ( width >= 800 ) {
			require('./desktop.js');
		}
		
		$('.feature-point').on('click', function(e){
			e.preventDefault();
			$('.features-list').toggleClass('active');
			$('.feature').removeClass('active');
			$(this).parent().toggleClass('active');
		});

		$('.close-x').on('click', function(e){
			e.preventDefault();
			$('.features-list').removeClass('active');
			$(this).parent().parent().removeClass('active');
		});
		
	}
	
	if ($('body').hasClass('store')) {
		require('./store.js');
	}

	if ($('body').hasClass('checkout')) {
		require('./checkout.js');
		require('./components/tabs.js');
	}

	$('.scroll-to-start a').on('click', function(e){
		e.preventDefault();
		$(window).scrollTo('#why', 1000, { offset:{top: 800} });
	});


	$('.back-top').on('click', function(e){
		e.preventDefault();
		$(window).scrollTo(0, 5000);
	});
	
});


