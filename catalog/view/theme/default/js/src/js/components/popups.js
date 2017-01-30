icon = require('./icons.js');

window.createPopup = function(view) {

	$.ajax({
		url: view,
		cache: false
	}).done(function( html ){
	
		//$('.popup-wrap').remove();
		
		var template = '<div class="popup-wrap">';
			template +=	'<div class="overlay"></div>';

			template +=	'<div class="popup-container">';
				template +=	'<div class="popup-content">';

				template += html;			

				template +=	'</div><!-- .popup-content -->';
				template +=	'<a href="javascript:void(0)" class="x" onclick="$(this).parent().parent().remove()">';
					template +=	icon('x');
				template +=	'</a>';
			template +=	'</div><!-- .popup-container -->';
		template += '</div><!-- .popup-wrap -->';
		
		$(document.body).append(template);
	});

}

window.popupFromPopup = function(view) {
	$('.popup-container').addClass('fadeOut');

	setTimeout( function(){
		$.ajax({
			url: view,
			cache: true
		}).done(function( html ){
			$('.popup-container').removeClass('fadeOut');
			$('.popup-content').html(html);
		});
	}, 500);
}

window.toast = function(message, type, callback) {
	var template = '<div class="toast">';
	template += '<div class="message">';
	
	if (type === 'success') {
		template += icon('check')
	}

	template += message;
	template += '</div>';
	template += '</div>';

	$('body').append(template);

	setTimeout(function(){
		$('.toast').addClass('fadeOut');
	}, 1500)

	setTimeout(function(){
		$('.toast').remove;
		callback();
	}, 2000)
}
