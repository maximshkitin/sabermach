<?php echo $header; ?>
  <div class="user-page edit-fields" id="content">
    <div class="container">
      <div class="row">
        <aside class="col-md-4" id="aside">
          <div id="avatar">
            <img src="<?php echo $avatar;?>" alt="<?php echo htmlspecialchars($firstname . ' ' .$lastname);?>">
          </div>
          <h2>My Account</h2>
          <ul>
            <li><a href="<?php echo $dashboard;?>"><i class="fa fa-tachometer"></i>  Dashboard</a></li>
            <li><a href="<?php echo $order; ?>"><i class="fa fa-shopping-cart"></i> Orders</a></li>
            <li><a href="<?php echo $edit; ?>"><i class="fa fa-user"></i> Account Details</a></li>
            <!-- <li><a href="<?php echo $knb; ?>"><i class="fa fa-archive"></i> Knowledge Base</a></li> -->
            <li><a href="<?php echo $mb; ?>"><i class="fa fa-group"></i> Support Message board</a></li>
          </ul>
         <!--  <div class="note">
            <i class="fa fa-info-circle"></i>
            Visit <a href="<?php echo $knb;?>"><strong>knowlegdebase</strong></a> or <a href="<?php echo $mb;?>"><strong>message board</strong></a> for support
          </div> -->
        </aside>
        <section class="col-md-8" id="right-side">
          <div class="page-nav">
            <ul class="clearfix">
              <?php foreach ($breadcrumbs as $breadcrumb) : ?>
              <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
              <?php endforeach; ?>
            </ul>
          </div>
          <hr class="dark">
          <h1 class="content-heading">
            <i class="fa fa-user"></i>
            Account Details
          </h1>
          <?php if ($success) : ?>
          <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
          <?php endif; ?>
          <?php if ($error_warning) : ?>
          <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
          <?php endif; ?>
          <form action="<?php echo $payment_address['update']; ?>" method="post" enctype="multipart/form-data">
            <div class="content-subheading">
              Edit Billing Address
            </div>
            <hr class="dark">
            <div class="table-wrapper visible">
              <table>
                <tbody>
                  <tr>
                    <td>Country</td>
                    <td class="inputs-2">
                      <div class="input-field">
                        <select name="payment_address[country_id]" id="payment-input-country" class="dark-input">
                          <option value=""><?php echo $text_select; ?></option>
                          <?php foreach ($countries as $country) { ?>
                          <?php if ($country['country_id'] == $payment_country_id) { ?>
                          <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                          <?php } else { ?>
                          <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                          <?php } ?>
                          <?php } ?>
                        </select>
                        <?php if ($error_payment_country) { ?>
                        <div class="text-danger"><?php echo $error_payment_country; ?></div>
                        <?php } ?>
                      </div>
                      <div class="input-field">
                        <select name="payment_address[zone_id]" id="payment-input-zone" class="dark-input"></select>
                        <?php if ($error_payment_zone) { ?>
                        <div class="text-danger"><?php echo $error_payment_zone; ?></div>
                        <?php } ?>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <td>Address</td>
                    <td><div class="input-field">
                        <input class="dark-input" type="text"  id="payment-input-address" name="payment_address[address_1]" value="<?php echo $payment_address_1; ?>" required>
                        <?php if ($error_payment_address_1) { ?>
                        <div class="text-danger"><?php echo $error_payment_address_1; ?></div>
                        <?php } ?>
                      </div></td>
                  </tr>
                  <tr>
                    <td>Post code</td>
                    <td><div class="input-field">
                        <input class="dark-input" type="text"  id="payment-input-postcode" name="payment_address[postcode]" value="<?php echo $payment_postcode; ?>" required>
                        <?php if ($error_payment_postcode) { ?>
                        <div class="text-danger"><?php echo $error_payment_postcode; ?></div>
                        <?php } ?>
                      </div></td>
                  </tr>
                </tbody>
              </table>
            </div>
            <div class="buttons">
              <a href="<?php echo $back;?>" class="polygon-button o">
                Cancel
              </a>
              <div class="submit-wrap">
                <i class="fa fa-save"></i>
                <input type="submit" class="submit-button" value="Save">
              </div>
            </div>
          </form>
          <form action="<?php echo $shipping_address['update']; ?>" method="post" enctype="multipart/form-data">
            <div class="content-subheading clearfix" style="margin-top: 60px;">
              <div style="float: left;">Edit Shipping Address</div>
              <label class="sub-check" for="same_address">
                <input type="checkbox" id="same_address">
                Ship to billing address
              </label>
            </div>
            <hr class="dark">
            <div class="table-wrapper visible">
              <table>
                <tbody>
                  <tr>
                    <td>Country</td>
                    <td class="inputs-2">
                      <div class="input-field">
                        <select name="shipping_address[country_id]" id="shipping-input-country" class="dark-input">
                          <option value=""><?php echo $text_select; ?></option>
                          <?php foreach ($countries as $country) { ?>
                          <?php if ($country['country_id'] == $shipping_country_id) { ?>
                          <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                          <?php } else { ?>
                          <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                          <?php } ?>
                          <?php } ?>
                        </select>
                        <?php if ($error_shipping_country) { ?>
                        <div class="text-danger"><?php echo $error_shipping_country; ?></div>
                        <?php } ?>
                      </div>
                      <div class="input-field">
                        <select name="shipping_address[zone_id]" id="shipping-input-zone" class="dark-input"></select>
                        <?php if ($error_shipping_zone) { ?>
                        <div class="text-danger"><?php echo $error_shipping_zone; ?></div>
                        <?php } ?>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <td>Address</td>
                    <td><div class="input-field">
                        <input class="dark-input" type="text" id="shipping-input-address" name="shipping_address[address_1]" value="<?php echo $shipping_address_1; ?>" required>
                        <?php if ($error_shipping_address_1) { ?>
                        <div class="text-danger"><?php echo $error_shipping_address_1; ?></div>
                        <?php } ?>
                      </div></td>
                  </tr>
                  <tr>
                    <td>Post code</td>
                    <td><div class="input-field">
                        <input class="dark-input" type="text" id="shipping-input-postcode" name="shipping_address[postcode]" value="<?php echo $shipping_postcode; ?>" required>
                        <?php if ($error_shipping_postcode) { ?>
                        <div class="text-danger"><?php echo $error_shipping_postcode; ?></div>
                        <?php } ?>
                      </div></td>
                  </tr>
                </tbody>
              </table>
            </div>
            <hr class="dark">
            <div class="buttons">
              <a href="<?php echo $back;?>" class="polygon-button o">
                Cancel
              </a>
              <div class="submit-wrap">
                <i class="fa fa-save"></i>
                <input type="submit" class="submit-button" value="Save">
              </div>
            </div>
          </form>
        </section>
      </div>
    </div>
  </div>
  <div id="modal">
    <div class="loader-icon"></div>
  </div>

<script type="text/javascript"><!--
$('select#payment-input-country').on('change', function() {
  $.ajax({
    url: 'index.php?route=account/account/country&country_id=' + this.value,
    dataType: 'json',
    beforeSend: function() {
      $('select#payment-input-country').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
    },
    complete: function() {
      $('.fa-spin').remove();
    },
    success: function(json) {
      html = '<option value=""><?php echo $text_select; ?></option>';

      if (json['zone'] && json['zone'] != '') {
        for (i = 0; i < json['zone'].length; i++) {
          html += '<option value="' + json['zone'][i]['zone_id'] + '"';

          if (json['zone'][i]['zone_id'] == '<?php echo $payment_zone_id; ?>') {
            html += ' selected="selected"';
            }

            html += '>' + json['zone'][i]['name'] + '</option>';
        }
      } else {
        html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
      }

      $('#payment-input-zone').html(html);
    },
    error: function(xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
});

$('select#shipping-input-country').on('change', function() {
  $.ajax({
    url: 'index.php?route=account/account/country&country_id=' + this.value,
    dataType: 'json',
    beforeSend: function() {
      $('select#shipping-input-country').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
    },
    complete: function() {
      $('.fa-spin').remove();
    },
    success: function(json) {
      html = '<option value=""><?php echo $text_select; ?></option>';

      if (json['zone'] && json['zone'] != '') {
        for (i = 0; i < json['zone'].length; i++) {
          html += '<option value="' + json['zone'][i]['zone_id'] + '"';

          if (json['zone'][i]['zone_id'] == '<?php echo $shipping_zone_id; ?>') {
            html += ' selected="selected"';
            }

            html += '>' + json['zone'][i]['name'] + '</option>';
        }
      } else {
        html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
      }

      $('#shipping-input-zone').html(html);
      if($('#same_address').prop('checked')) {
        $('#shipping-input-zone').val($('#payment-input-zone').val());
      }
    },
    error: function(xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
});

$('select#shipping-input-country').trigger('change');
$('select#payment-input-country').trigger('change');

$('#same_address').change(function(e) {
  if($(this).prop('checked')) {
    $('#shipping-input-country').val($('#payment-input-country').val());
    $('select#shipping-input-country').trigger('change');
    $('#shipping-input-address').val($('#payment-input-address').val());
    $('#shipping-input-postcode').val($('#payment-input-postcode').val());
  }
})
//--></script>
<?php echo $footer; ?>