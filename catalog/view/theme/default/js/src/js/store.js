var icon = require('./components/icons.js');

(function() {


	/*------------------------------------------/
     * Choose Series
	 *-----------------------------------------*/
	$('.choose-series-radio').on('click', function(){
		var data = $(this).data();
		var rel = $(this).closest('li').data('rel');
		$('.choose-hilt:not(.hidden)').addClass('hidden');
		var hilt = $('.choose-hilt.' + rel).detach().removeClass('hidden');
		$(hilt[0]).insertAfter($('#saber-hilt'));

		$('.choose-color:not(.hidden)').addClass('hidden');
		var color = $('.choose-color.' + rel).detach().removeClass('hidden');
		$(color[0]).insertAfter($('#saber-color'));

		$('#sounds strong').html(data.sounds);
		$('#colors strong').html(data.colors);

		if(data.name === 'expert-t') {
			$('#series-selection').html('Expert ' + icon('thunder'));
		} else {
			$('#series-selection').html(data.name);			
		}

		
		$('#saber-series').addClass('done').removeClass('expanded');
		
		if ( !$('#saber-hilt').hasClass('done') ) {
			$('#saber-hilt').addClass('expanded');
		}

		if( $('.choose-color-radio').attr('type') === 'checkbox' ) {
			$('.choose-color-radio').attr('type', 'radio').prop({'checked': false, disabled: false});
		}

		if(data.name === 'Master') {
			$('.choose-color-radio').attr('type', 'checkbox').prop({'checked': true, disabled: true});
		}
	});


	/*------------------------------------------/
     * Choose Hilt
	 *-----------------------------------------*/
	$('.choose-hilt-radio').on('click', function(){
		var data = $(this).data();
		$('#hilt-selection').html(data.name);
		$('#saber-hilt').addClass('done').removeClass('expanded');
		$('#saber-color').addClass('expanded');

	});


	/*------------------------------------------/
     * Choose Color
	 *-----------------------------------------*/
	$('.choose-color-radio').on('click', function(){
		var data = $(this).data();

		$('#colors-selection').html(data.name);
		$('#saber-color').addClass('done').removeClass('expanded');
		$('#saber-photo').css('background-image', 'url(/dist/images/colors/saber-' + data.color + '.png)');
		console.log('hello');
	});


	$('.selection').on('click', function() {
		$(this).parent().addClass('expanded');
	});

})();