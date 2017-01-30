<fieldset>
  <legend>Contact Details</legend>
  <div class="input-wrap">
    <?php foreach ($customer_groups as $customer_group) : ?>
    <?php if ($customer_group['customer_group_id'] == $customer_group_id) : ?>
    <input type="hidden" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>"/>
    <?php endif; ?>
    <?php endforeach; ?>
    <label for="name">Full Name</label>
    <div class="input-2">
      <input type="text" name="firstname" value="<?php echo $firstname;?>" id="name">
      <input type="text" name="lastname" value="<?php echo $lastname;?>" id="lastname">
    </div>
  </div>
  <div class="input-wrap">
    <label for="phone">Phone</label>
    <input type="text" name="telephone" value="<?php echo $telephone;?>" id="phone">
  </div>
  <div class="input-wrap">
    <label for="email">Email</label>
    <input type="email" name="email" value="<?php echo $email;?>" id="email">
  </div>
</fieldset>
<fieldset>
  <legend>Billing Address</legend>
  <div class="input-wrap">
    <label for="billing-country">Country</label>
    <div class="input-2">
      <select name="country_id" id="billing-country">
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
      <select name="zone_id" id="billing-region"></select>
    </div>
  </div>
  <div class="input-wrap">
    <label for="billing-address">billing-Address</label>
    <input type="text" name="address_1" value="<?php echo $address_1;?>" id="billing-address">
  </div>
  <div class="input-wrap">
    <label for="billing-post-code">Post Code</label>
    <input type="text" name="postcode" value="<?php echo $postcode;?>" class="only-numbers" id="billing-post-code">
  </div>
</fieldset>
<?php if ($shipping_required) : ?>
<?php if ($shipping_address) : ?>
<input type="hidden" name="shipping_address" value="1" id="billing-same-address">
<?php else: ?>
<input type="hidden" name="__shipping_address" value="1" id="billing-same-address">
<?php endif;?> 
<?php endif;?>   
<?php echo $captcha; ?>

<script type="text/javascript"><!--
$('#user-form select[name=\'country_id\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#user-form select[name=\'country_id\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
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

			$('#user-form select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('#user-form select[name=\'country_id\']').trigger('change');
//--></script>