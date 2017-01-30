<fieldset id="shipping-address" class="shipping-address">
  <legend>
    Shipping Address 
    <div class="checkbox">
      <label for="same-address">Ship to billing address</label>
      <input type="checkbox" name="shipping_address" value="1" id="same-address">
    </div>
  </legend>
  <div class="fields-wrap expanded">
  <div class="input-wrap">
    <label for="shipping-country">Country</label>
    <div class="input-2">
      <select name="country_id" id="shipping-country">
        <option value="">Select Country</option>
        <?php if(!empty($countries)):?>
        <?php foreach ($countries as $country) :?>
        <?php if ($country['country_id'] == $country_id) : ?>
        <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
        <?php else : ?>
        <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
        <?php endif; ?>
        <?php endforeach;?>
        <?php endif; ?>
      </select>
      <select name="zone_id" id="shipping-region"></select>
    </div>
  </div>
  <div class="input-wrap">
    <label for="shipping-address">Shipping-Address</label>
    <input type="text" name="address_1" value="<?php echo $address_1;?>" id="shipping-address">
  </div>
  <div class="input-wrap">
    <label for="shipping-post-code">Post Code</label>
    <input type="text" name="postcode" value="<?php echo $postcode;?>" class="only-numbers" id="shipping-post-code">
  </div>
</div>
  <div class="form-note">
    <svg viewBox="0 0 150 150" class="icon icon-info">
      <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_info"></use>
    </svg>
    Item will be shipped to the above billing address
  </div>
</fieldset>

<script type="text/javascript"><!--
$('#shipping-form select[name=\'country_id\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#shipping-form select[name=\'country_id\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
		},
		complete: function() {
			$('.fa-spin').remove();
		},
		success: function(json) {
			html = '<option value="">Select Region</option>';

			if (json['zone'] && json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
					html += '<option value="' + json['zone'][i]['zone_id'] + '"';

					if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
						html += ' selected="selected"';
          			}

					html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}

			$('#shipping-form select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('#shipping-form select[name=\'country_id\']').trigger('change');
//--></script>