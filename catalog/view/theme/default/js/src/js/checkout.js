(function(){
	$('#same-address').on('click', function(){
		$('.shipping-address .fields-wrap').toggleClass('expanded');
		$('.shipping-address .form-note').toggleClass('show');
	});
	
	$('#continue-to-payment').on('click', function(){
		$('#payment-selection').addClass('expanded');
		$('#address-info').addClass('done').removeClass('expanded');
		$('.col-right-footer').show();
	});

	$('#back-to-address').on('click', function(){
		$('#payment-selection').removeClass('expanded');
		$('#address-info').removeClass('done').addClass('expanded');
		$('.col-right-footer').hide();
	});
})();