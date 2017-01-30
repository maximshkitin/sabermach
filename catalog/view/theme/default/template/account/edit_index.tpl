<?php echo $header; ?>
  <div class="user-page edit" id="content">
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
          <div class="contact-details">
            <div class="content-subheading clearfix">
              <div style="float: left;">Contact Details</div>
              <a class="oval-btn" href="<?php echo $edit_profile;?>">Edit <i class="fa fa-pencil"></i></a>
            </div>
            <hr class="dark">
            <div class="details clearfix">
              <div class="col-6 mob-tac">
                <div class="avatar" id="upload-avatar">
                  <div class="img-cut">
                    <img src="<?php echo $avatar_small;?>" alt="<?php echo htmlspecialchars($firstname . ' ' .$lastname);?>">
                  </div>
                  <div class="upload">
                    <i class="fa fa-upload"></i>
                    upload image
                  </div>
                </div>
              </div>
              <div class="col-6 clearfix kek">
                <div>
                  <p>Full Name</p>
                  <p>: <?php echo $firstname . ' ' .$lastname;?></p>
                </div>
                <div>
                  <p>Phone</p>
                  <p>: <?php echo $telephone;?></p>
                </div>
                <div>
                  <p>Email</p>
                  <p>: <?php echo $email;?></p>
                </div>
              </div>
            </div>
          </div>
          <div class="addresses">
            <div class="content-subheading clearfix">
              <div style="float: left;">Addresses</div>
              <a class="oval-btn" href="<?php echo $address;?>">
                Edit
                <i class="fa fa-pencil"></i>
              </a>
            </div>
            <hr class="dark">
            <div class="row bb">
              <?php if(!empty($payment_address) && !empty($payment_address['address_1'])):?>
              <div class="col-md-6">
                <p class="title">
                  Billing Address
                </p>
                <p>
                  <i class="fa fa-map-marker"></i>
                  <?php echo $payment_address['address_1'] . ', ' . (!empty($payment_address['zone_code']) ? $payment_address['zone_code'] . ', ' : '') . $payment_address['iso_code_2'];?>.
                </p>
              </div>
              <?php endif;?>
              <?php if(!empty($shipping_address) && !empty($shipping_address['address_1'])):?>
              <div class="col-md-6">
                <p class="title">
                  Shipping Address
                </p>
                <p>
                  <i class="fa fa-truck"></i>
                  <?php echo $shipping_address['address_1'] . ', ' . (!empty($shipping_address['zone_code']) ? $shipping_address['zone_code'] . ', ' : '') . $shipping_address['iso_code_2'];?>.
                </p>
              </div>
              <?php endif;?>
            </div>
          </div>
          <div class="info-box">
            <p>
            <i class="fa fa-info-circle"></i>
              By default, the saved addresses above will be used (auto-filled) on your checkout page. Lorem ipsum.
            </p>
          </div>
        </section>
      </div>
    </div>
  </div>
  <div id="modal">
    <div class="loader-icon"></div>
  </div>

<script type="text/javascript"><!--
$('#upload-avatar').on('click', function() {
	var node = this;

	$('#form-upload').remove();

	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

	$('#form-upload input[name=\'file\']').trigger('click');

	if (typeof timer != 'undefined') {
    	clearInterval(timer);
	}

	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);

			$.ajax({
				url: 'index.php?route=tool/upload/avatar',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
					//$(node).button('loading');
				},
				complete: function() {
					//$(node).button('reset');
				},
				success: function(json) {
					$(node).parent().find('.text-danger').remove();

					if (json['error']) {
						$(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
					}

					if (json['success']) {
            $(node).find('img').attr('src', json['image']);
            $('#avatar').find('img').attr('src', json['image']);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});
//--></script>
<?php echo $footer; ?>
