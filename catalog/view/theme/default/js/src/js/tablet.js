(function(){
	var controller = new ScrollMagic.Controller();

	var starScroll = new TimelineMax({repeat: 0, yoyo: true})
		.add([
			TweenMax.fromTo("#intro .saber-image", 1, {rotation: 90, y: 270, scale: 0.5}, {rotation: 0}),
			TweenMax.to("#intro .scroll-to-start", 0.5, {opacity: 0}),
		]);

	var blinkScroll = new TimelineMax({repeat: -1, yoyo: true})
		.add(TweenMax.to("#intro .scroll-to-start span", 0.7, {opacity: 0}) );


	/*var fadeSaber = new TimelineMax({repeat: 0, yoyo: true})
		.add(TweenMax.to("#intro .saber-image", 1, {y: 700}) );*/

	var intro = new ScrollMagic.Scene({
		triggerElement: '#intro',
		duration: 700,
		triggerHook: 'onLeave'
	})
	.setTween(starScroll)
	.setPin('#intro')
	//.addIndicators()
	.addTo(controller);

	





	var split = new TimelineMax({repeat: 0, yoyo: true})
		.add([
			TweenMax.to(".sabermach-title .to-left", 1, {x: -1500, opacity: 0}),
			TweenMax.to(".sabermach-title .to-right", 1, {x: 1500, opacity: 0}),
		]);

	new ScrollMagic.Scene({
		triggerElement: "#intro",
		triggerHook: 'onEnter',
		duration: 2000,
		offset: 1800
	})
	.setTween(split)
	//.addIndicators()
	//.setPin('.sabermach-title')
	.addTo(controller);







	new ScrollMagic.Scene({
		triggerElement: "#why",
		triggerHook: 'onEnter'
	})
	.setClassToggle("#intro .saber-image", "fixed")
	.addTo(controller);






	var why = new ScrollMagic.Scene({
		triggerElement: '#why',
		duration: 4000,
		triggerHook: 'onLeave'
	})
	//.setTween(showDescription)
	.setPin('#why')
	.addTo(controller)




	var showDescription = new TimelineMax({repeat: 0, yoyo: true})
	.add([
		TweenMax.fromTo("#why .why-intro", 0.1, {x: -1000}, {x: 0}),
		TweenMax.to("#intro .saber-image", 0.1, {x: 150, y:-270, scale: 1.2}),
		TweenMax.to("#why .do-action-text", 0.1, {opacity:1})
	]);

	var whyDescription = new ScrollMagic.Scene({
		triggerElement: '#why',
		duration: 700,
		triggerHook: 'onLeave'
	})
	.setTween(showDescription)
	.addTo(controller);


	//360 Rotation
	new ScrollMagic.Scene({
		triggerElement: '#why',
		triggerHook: 'onLeave',
		duration: 2000,
		offset: 1500
	})
	.setTween(TweenMax.to("#intro .saber-photo", .5, {backgroundPosition:"-4305px 0", ease:SteppedEase.config(35), yoyo:true, repeat: 0}))
	//.addIndicators('rotate360')
	.addTo(controller);


	var showList = new TimelineMax({repeat: 0, yoyo: true})
	.add([
		TweenMax.to("#why .why-intro", 0.1, {x: -1000}),
		TweenMax.to("#why .why-list", 0.1, {x:0}),
		TweenMax.to("#intro .saber-image", 0.1, {x:-200}),
		TweenMax.to("#why .do-action-text", 0.1, {x:-200})
	]);

	var showListScene = new ScrollMagic.Scene({
		triggerElement: '#why',
		duration: 700,
		offset: 1200,
		triggerHook: 'onLeave'
	})
	.setTween(showList)
	.addTo(controller);

	new ScrollMagic.Scene({
		triggerElement: "#why",
		triggerHook: 'onLeave',
		offset: 1700,
	})
	.setClassToggle("#item-1", "active")
	.addTo(controller);

	new ScrollMagic.Scene({
		triggerElement: "#why",
		triggerHook: 'onLeave',
		offset: 2200,
	})
	.setClassToggle("#item-2", "active")
	.addTo(controller)
	.on("enter", function (event) {
		$('#item-1').removeClass('active');
	})
	.on("leave", function (event) {
		$('#item-1').addClass('active');
	});

	new ScrollMagic.Scene({
		triggerElement: "#why",
		triggerHook: 'onLeave',
		offset: 2700,
	})
	.setClassToggle("#item-3", "active")
	.addTo(controller)
	.on("enter", function (event) {
		$('#item-2').removeClass('active');
	})
	.on("leave", function (event) {
		$('#item-2').addClass('active');
	});

	new ScrollMagic.Scene({
		triggerElement: "#why",
		triggerHook: 'onLeave',
		offset: 3200,
	})
	.setClassToggle("#item-4", "active")
	.addTo(controller)
	.on("enter", function (event) {
		$('#item-3').removeClass('active');
	})
	.on("leave", function (event) {
		$('#item-3').addClass('active');
	});



	var hideList = new TimelineMax({repeat: 0, yoyo: true})
	.add([
		TweenMax.to("#why .why-list", 0.1, {x:2000}),
		TweenMax.to("#intro .saber-image", 0.1, {x:0, y:270, scale: 0.5}),
		TweenMax.to("#why .do-action-text", 0.1, {x:0, opacity:0})
	]);

	var whyDescription = new ScrollMagic.Scene({
		triggerElement: '#why',
		duration: 700,
		offset: 3700,
		triggerHook: 'onLeave'
	})
	.setTween(hideList)
	.addTo(controller);




	new ScrollMagic.Scene({
		triggerElement: '#features',
		duration: 3200,
		triggerHook: 'onLeave'
	})
	.setPin('#features')
	.addTo(controller);


	var rotateSaber = TweenMax.to("#intro .saber-image", 1, {rotation:270})

	new ScrollMagic.Scene({
		triggerElement: '#features',
		duration: 1500,
		triggerHook: 'onLeave'
	})
	.setTween(rotateSaber)
	.addTo(controller);



	var showFeatures = new TimelineMax({repeat: 0, yoyo: true})
	.add([
		TweenMax.to("#intro .saber-image", 0.1, {opacity:0, position: 'relative'}),
		TweenMax.fromTo("#features .saber-image", 0.2, {opacity:0, rotation: 90, scale: 0.5, y: 270}, {opacity:1}),
		TweenMax.fromTo(".features-list", 0.9, {opacity:0}, {opacity:1}),
		TweenMax.to(".do-action-text", 1, {opacity:1}),
	]);

	var keyFeautes = new ScrollMagic.Scene({
		triggerElement: '#features',
		duration: 800,
		offset: 1500,
		triggerHook: 'onLeave'
	})
	.setTween(showFeatures)
	.addTo(controller);



	new ScrollMagic.Scene({
		triggerElement: '#carousel',
		triggerHook: 'onLeave',
	})
	.setClassToggle("#cta", "active")
	.addTo(controller);

	new ScrollMagic.Scene({
		triggerElement: '#carousel',
		triggerHook: 'onLeave',
		offset: -800
	})
	.on('start', function(event){
		if (event.scrollDirection == 'FORWARD') {
			$(window).scrollTo('#carousel', 1000);
		}
	})
	//.addIndicators()
	.addTo(controller);

	var carousel = new Swiper('#sabers-carousel', {
		effect: 'coverflow',
	    grabCursor: true,
	    centeredSlides: true,
	    nextButton: '.swiper-button-next',
	    prevButton: '.swiper-button-prev',
	    slidesPerView: 2,
		coverflow: {
	        rotate: 0,
	        stretch: 20,
	        depth: 40,
	        modifier: 6,
	        slideShadows : false
	    }
	});

})();