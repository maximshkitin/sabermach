var barPosition;
var barHeight;
var includePosition;
$(window).load(function(){
	$('#modal .loader-icon').fadeOut(400);
	$('#modal').fadeOut(1000);
	var descrBoxTitle = $('.right-line.first .title > div').width();
	var descrBoxTitleLast = $('.right-line.last .title > div').width();
	$('.right-line.first .title b').css('left', descrBoxTitle + 20);
	$('.right-line.last .title b').css('left', descrBoxTitleLast + 20);

	if ($('body').hasClass('product')) {
		barPosition = $('#fixed-toggle').offset().top;
		barHeight = $('#fixed-toggle').height();
		includePosition = $('.include').offset().top;
	}
});
$(document).ready(function(){
	$(window).click(function(){
		if ($('.fake-select').hasClass('open')) {
			$('.fake-select').removeClass('open');
		}
	});
	$(document).click(function(event) { 
	    if(!$(event.target).closest('.dd-menu').length) {
	        if($('.dd-menu > ul').is(":visible")) {
	            $('.dd-menu > ul').removeClass('active');
	            $('.dd-menu').removeClass('open');
	        }
	    }        
	});
	$('.dd-menu').click(function(){
		if (!$(this).hasClass('store')) {
			$(this).toggleClass('open');
			$(this).find('ul').toggleClass('active');
		}
	});
	function slideDown() {
		$('.categories > li').addClass('open');
		$('.categories > li').find('.submenu').slideDown('fast');
		$('.categories > li').find('.fa').removeClass('fa-caret-right').addClass('fa-caret-down');
	}

	function slideUp() {
		$('.categories > li').removeClass('open');
		$('.categories > li').find('.submenu').slideUp('fast');
		$('.categories > li').find('.fa').removeClass('fa-caret-down').addClass('fa-caret-right');
	}
	if ($('body').hasClass('knlg')) {
		$('#livefilter-list .submenu').liveFilter('#livefilter-input', 'li');
	}
	

	$('#livefilter-input').on('input paste propertychange',function(){
		var val = $(this).val();
		console.log($(this).parent().find('.fa'))
		if (val == '') {
			$(this).parent().find('.fa').removeClass('fa-close').addClass('fa-search');
			slideUp();
		}
		else {
			if ($(this).parent().find('.fa').hasClass('fa-search')) {
				$(this).parent().find('.fa').removeClass('fa-search').addClass('fa-close');
			}
			slideDown();
		}
	});
	$('.livefilter .fa').click(function(){
		if ($(this).hasClass('fa-close')) {
			$('#livefilter-input').val('');
			slideUp();
			$('.categories > li .submenu li').css('display', 'list-item');
			$(this).parent().find('.fa').removeClass('fa-close').addClass('fa-search');
		}
		
	});
	$('.pinned-images .item a').click(function(){
		$(this).closest('.item').remove();
		return false;
	});
	$('.to-top').click(function(){
		var isSafari = /safari/.test(navigator.userAgent.toLowerCase());
		if (isSafari) {
	 		$('body').animate({ scrollTop: 0 }, 1000);
		} 
    else {
     	$('html').animate({ scrollTop: 0 }, 1000);
    }
	});
	$('.list-categories .categories > li').click(function(){
		$(this).toggleClass('open');
		$(this).find('.submenu').slideToggle('fast');
		if ($(this).hasClass('open')) {
			$(this).find('.fa').removeClass('fa-caret-right').addClass('fa-caret-down');
		}
		else {
			$(this).find('.fa').removeClass('fa-caret-down').addClass('fa-caret-right');
		}
	});
	$('.expand-all').click(function(){
		var len = $('.categories > li').length;
		var flag = false;
		for (var i = 0; i < len; i++) {
			var current = $('.categories > li').eq(i);
			if (!current.hasClass('open')) {
				flag = true;
				break;
			}
		}
		if (flag) {
			slideDown();
		}
		else {
			slideUp();
		}
		return false;
	});

	$('.show-form').click(function(){
		$('#right-side section.active').fadeOut(300);
		setTimeout(function(){
			$('#contact-form').fadeIn(300);
			if (isSafari) {
		 		$('body').animate({ scrollTop: $('#right-side').offset().top - 100 }, 500);
			} 
	    else {
	     	$('html').animate({ scrollTop: $('#right-side').offset().top - 100 }, 500);
	    }
		},300);
		var isSafari = /safari/.test(navigator.userAgent.toLowerCase());
		return false;
	});
	$('.fake-select').click(function(e){
		$(this).toggleClass('open');
		e.stopPropagation();
	});
	$('.fake-select li a').click(function(){
		var text = $(this).text();
		$(this).closest('.fake-select').find(' > span').html(text);
		$(this).closest('.fake-select').addClass('validate');
		$(this).closest('.fake-select').removeClass('open');
		return false;
	});

	$('.fake-select a, #checkbox-confirm').click(function(){
		if ($('#checkbox-confirm').is(':checked')) {
			$('#message-form').addClass('validate');
			$('#message-form').removeClass('novalidate');
		}
		else {
			$('#message-form').removeClass('validate');
			$('#message-form').addClass('novalidate');
		}
	});
	$('.close-pop').click(function(){
		$(this).closest('.pop-up').fadeOut(300);
		return false;
	});
	

	$('.touch #main-nav ul li.dd-menu.store').click(function(e){
		if ($(e.target.parentNode).hasClass('store'))
			$(this).toggleClass('active');
	});

	// store 


	if ($(window).width() >= 800) {
		if ($('body').hasClass('store')) {
			if ($('.col-left').hasClass('fixed-l')) {
				var w = $('.l-center.content').width() * 0.4;
				$('.col-left.fixed-l').css('width', w);
			}
		}	
	}

	$('.choose-series-radio').on('click', function(){
		var id = '#' + $(this).attr('id');
		var ex = $(this).data('product');
		$('.choose-hilt').find('ol').addClass('hidden');
		if (ex === 54 || ex === 53) {
			$('#saber-color').addClass('expanded');
			$('#saber-hilt').removeClass('done');
		}
		else {
			$('.choose-hilt').find('[data-item="' + id + '"]').removeClass('hidden');
		}
		$('.choose-color').find('ol').addClass('hidden');
		$('.choose-color').find('[data-item="' + id + '"]').removeClass('hidden');
	});

	$('.choose-hilt-radio').click(function(){
		var newImg = $(this).data('image');
		console.log(newImg);
		if (newImg != undefined)
			$('#saber-photo').css('backgroundImage', 'url("' + newImg + '")');
	});


	$('#payment-content .tabs a').click(function(){
		if(!$(this).hasClass('active')) {
			var id = $(this).data('rel');
			$('#payment-content .tabs a').removeClass('active');
			$(this).addClass('active');
			$('.method-area').fadeOut(200);
			$('.hidden-radios input').attr('checked', false);
			$('input.' + id).attr('checked', true);
			setTimeout(function(){
				$('#' + id).fadeIn(200);
			}, 200);
		}
		
		return false;
	});
	
	$('.close-hilt-pop').click(function(){
		$('#hilts-slider').fadeOut(300);
		$('#hilts-slider .bx-wrapper').hide();
	});
	$('#hilts-slider').click(function(e){
		if (e.target.id === "hilts-slider") {
			$(this).fadeOut(300);
			$('#hilts-slider .bx-wrapper').hide();
		}
	});

});
$(window).resize(function(){
	if ($('body').hasClass('store')) {
		if ($('.col-left').hasClass('fixed-l')) {
			if ($(window).width() >= 800) {
				var w = $('.l-center.content').width() * 0.4;
				$('.col-left.fixed-l').css('width', w);
			}
			else {
				$('.col-left.fixed-l').css('width', 'auto');
			}
		}	
	}
	
});
$(window).scroll(function(){
	var scrollTop = $(window).scrollTop();
	if ($('body').hasClass('product')) {
		if (barPosition <= scrollTop) {
			$('#fixed-toggle').addClass('fixed-bar');
			$('.unique-features').css('margin-top', barHeight);
			$('#fixed-toggle .polygon-button').addClass('yellow');
		}
		else {
			$('#fixed-toggle').removeClass('fixed-bar');
			$('.unique-features').css('margin-top', 0);
			$('#fixed-toggle .polygon-button').removeClass('yellow');
		}
		if (includePosition <= scrollTop) {
			$('.click-slide').addClass('active');
		}
	}
	
});