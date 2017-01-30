<?php echo $header; ?>
<div class="main">
  <main class="l-center content">
    <div class="col-left">
      <div class="title">
        <span class="logo-sm"><?php echo $name;?></span>
        <span class="action">
          <svg viewBox="0 0 150 150" class="icon icon-shine">
            <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_shine"></use>
          </svg>
          Items in your cart
          <svg viewBox="0 0 150 150" class="icon icon-shine">
            <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_shine"></use>
          </svg>
        </span>
      </div>
      <div class="checkout-calculator">
        <ol class="items">
        <?php foreach ($products as $product) : ?>
          <li class="item" id="cart-item-<?php echo $product['cart_id']; ?>">
            <div class="item-content">
              <?php if ($product['thumb']) : ?>
              <a href="<?php echo $product['href']; ?>" class="item-photo">
                <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />                
              </a>
              <?php else:?>
              <div class="item-photo"></div>
              <?php endif; ?>
              <div class="item-description">
                <span class="item-series"><?php echo $product['name']; ?>
                  <?php if (!$product['stock']) : ?>
                  <span class="text-danger">***</span>
                  <?php endif; ?>
                </span>
                <?php if($product['hilt']) :?>
                <span class="item-hilt"><?php echo $product['hilt']['value'];?></span>
                <?php endif; ?>
                <?php if($product['colors']) :?>
                <?php if(count($product['colors']) > 1) :?>
                <span class="item-colours"><?php echo count($product['colors']);?> Colours</span>
                <?php else:?>
                <?php $colors = reset($product['colors']);?>
                <span class="item-colours"><?php echo $colors['value'];?></span>
                <?php endif;?>
                <?php endif;?>
              </div>
                <div class="item-quantity">
                  <input type="text" class="quantity" name="quantity[<?php echo $product['cart_id']; ?>]" value="<?php echo $product['quantity']; ?>" size="2" onchange="cart.update('<?php echo $product['cart_id']; ?>', this.value);return false;"/>
                </div>
                <div class="item-total"><?php echo $product['total']; ?></div>
            </div>
            <div class="remove-item">
                  <a href="#" id="remove-item" onclick="cart.remove('<?php echo $product['cart_id']; ?>');return false;">
                  <svg viewBox="0 0 150 150" class="icon icon-trash">
                    <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_trash"></use>
                  </svg>
                  <?php echo $button_remove; ?>
                  </a>
            </div>
          </li>
        <?php endforeach;?>
        </ol>
        <table class="order-sub-totals">
          <col width="70">
          <col width="30">
          <tbody>
          <?php foreach ($totals as $_total) : ?>
            <tr>
              <th><?php echo $_total['title']; ?></th>
              <td><?php echo $_total['text']; ?></td>
            </tr>
          <?php endforeach; ?>
          </tbody>
        </table>
        <?php if(isset($total) && !empty($total)):?>
        <table class="order-total">
          <tr>
            <th><?php echo $total['title'];?></th>
            <td><?php echo $total['text'];?> <span class="currency"><?php echo $total['currency'];?></span></td>
          </tr>
        </table>
        <?php endif;?>
      </div>
      <div class="saber-footer">
        <div class="get-help">
          <svg viewBox="0 0 150 150" class="icon icon-info">
            <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_info"></use>
          </svg>
          Get help buying. <strong><?php echo $help_email;?><?php echo (!empty($help_phone) && !empty($help_email)) ? ' • ' : '';?><?php echo $help_phone;?></strong>
        </div>
      </div>
    </div>

    <div class="col-right">
          <dl class="store-steps">
            <dt id="address-info" class="expanded">
              <svg viewBox="0 0 150 150" class="icon icon-shipping">
                <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_shipping"></use>
              </svg>
              Billing & shipping
            </dt>

            <dd class="contact-details">
              <div class="billing-form">
                <form id="user-form"></form>
                <form id="shipping-form"></form>
                <form id="shipping-method"></form>
                <form id="payment_form"></form>

                <a href="javascript:void(0)" id="continue-to-payment" class="btn">
                  <svg viewBox="0 0 150 150" class="icon icon-shopping">
                    <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_shopping"></use>
                  </svg>
                  Continue
                </a>
              </div>
            </dd>

            <dt id="payment-selection">
              <svg viewBox="0 0 150 150" class="icon icon-card">
                <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_card"></use>
              </svg>
              Payment
            </dt> 
            <dd id="payment_method_form">
            	
            </dd>
          </dl>
          <div class="col-right-footer">
            <div class="footer-note">
              <svg viewBox="0 0 150 150" class="icon icon-alert">
                <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_alert"></use>
              </svg>
              <?php if($text_agree) : ?>
              	By clicking 'Submit Order', you accept and agree to all terms of SaberMach's <a href="<?php echo $text_agree ?>">Terms and Policy.</a>
          	  <?php endif; ?>
            </div><!-- .footer-note -->

            <button id="back-to-address" class="btn btn--transparent">
              <div class="border"></div>
              <span class="text">Back</span>
            </button>

            <!-- <button id="submit_order" type="submit" class="btn">
              <svg viewBox="0 0 150 150" class="icon icon-shopping">
                <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_shopping"></use>
              </svg>
              Submit Order
            </button> -->
            <div style="display: inline-block; float: right" id="submit_order"></div>
			
			<!-- <div id="confirm_block" style="display: none1;" ></div> -->

          </div>
        </div><!-- .col-right -->

  </main> 
</div>
<script src="catalog/view/theme/default/js/home/app.js" type="text/javascript"></script>
<script src="catalog/view/theme/default/js/validation/jquery.validate.min.js" type="text/javascript"></script>
<script type="text/javascript"><!--
$(document).on("keypress", ".quantity, .only-numbers", function (e) {
  if ( event.keyCode == 46 || event.keyCode == 8 ) {
      // 
  } else {
      if (event.keyCode < 48 || event.keyCode > 57 ) {
        event.preventDefault(); 
      } 
    }
});
//--></script>
<script type="text/javascript"><!--
$.ajax({
    url: 'index.php?route=checkout/guest',
    dataType: 'html',
    success: function(html) {
      $('#user-form').html(html);
      $('#user-form select[name=\'country_id\']').trigger('change');
      $('#user-form #billing-country').trigger('change');
      /*if($("#billing-same-address").attr("name") == "shipping_address") {
        "shipping_address"
      }*/
    } 
});
$.ajax({
  url: 'index.php?route=checkout/guest_shipping',
  dataType: 'html',
  success: function(html) {
    $('#shipping-form').html(html);
    if($("#billing-same-address").attr("name") == "shipping_address") {
      $("#shipping_address").prop("checked", true);
    } else {
      $("#shipping_address").prop("checked", false);
    }
  } 
});
/*$.ajax({
  url: 'index.php?route=checkout/payment_method',
  dataType: 'html',
  success: function(html) {
    $('#payment_form').html(html);
  } 
});*/
$("#continue-to-payment").on("click", function(e) {
  e.preventDefault();
  var form = $("#user-form");
  var shipping_form = $("#shipping-form");
  <?php if($logged) : ?>
  var addr_link = 'index.php?route=checkout/payment_address/save',
      ship_link = 'index.php?route=checkout/shipping_address/save'
  <?php else : ?>
  var addr_link = 'index.php?route=checkout/guest/save',
      ship_link = 'index.php?route=checkout/guest_shipping/save'
  <?php endif; ?>
  form.validate();
  if(!form.valid()) {
    $('body').animate({ scrollTop: form.offset().top - 175 }, 500);
  } else {
    $.ajax({
      url: addr_link,
      type: 'post',
      data: form.serialize(),
      dataType: 'json',
      success: function(json) {
        if(!json.error) {
          if(!$("#same-address").is(":checked")) {
            shipping_form.validate();
            if(!shipping_form.valid()) {
              $('body').animate({ scrollTop: shipping_form.offset().top - 100 }, 500);
            } else {
                  $.ajax({
                      url: ship_link,
                      type: 'post',
                      data: $('#shipping-address').serialize(),
                      dataType: 'json',
                      success: function(json) {
                        $.ajax({
                           url: 'index.php?route=checkout/shipping_method',
                           dataType: 'html',
                           success: function(html) {
                            $('#shipping-method').html(html);
                                $.ajax({
                                  url: 'index.php?route=checkout/shipping_method/save',
                                  type: 'post',
                                  data: $(document).find('input[name=shipping_method]:checked'),
                                  dataType: 'json',
                                  success: function(json) {
                                    $("#continue-to-payment").addClass("valid");
                                    $("#payment-selection").addClass("expanded");
                                    $("#address-info").addClass("done").removeClass("expanded");
                                    $(".col-right-footer").show();


                                    $.ajax({
                                       url: 'index.php?route=checkout/payment_method',
                                       dataType: 'html',
                                       success: function(json) {
                                          $('#payment_method_form').html(json);
                                        }
                                    });


                                  }
                                });
                           }
                        });
                        
                      }
                  });
            }
          } else {
                $.ajax({
                    url: ship_link,
                    type: 'post',
                    data: $('#shipping-address').serialize(),
                    dataType: 'json',
                    success: function(json) {
                      $.ajax({
                         url: 'index.php?route=checkout/shipping_method',
                         dataType: 'html',
                         success: function(html) {
                            $('#shipping-method').html(html);
                              $.ajax({
                                url: 'index.php?route=checkout/shipping_method/save',
                                type: 'post',
                                data: $('#shipping-method').serialize(),
                                dataType: 'json',
                                success: function(json) {
                                  $("#continue-to-payment").addClass("valid");
                                  $("#payment-selection").addClass("expanded");
                                  $("#address-info").addClass("done").removeClass("expanded");
                                  $(".col-right-footer").show();


                                  $.ajax({
                                     url: 'index.php?route=checkout/payment_method',
                                     dataType: 'html',
                                     success: function(json) {
                                        $('#payment_method_form').html(json);
                                      }
                                  });


                                }
                              });
                         }
                      });
                      
                    }
                });
          }
        }
      }
    });
  }
});


// $('#submit_order').on('click', function() {
// 	  $('#confirm_block #button-confirm').trigger('click');
// });


$("#user-form").validate({
  rules: {
    "firstname": {
      required: true
    },
    "lastname": {
      required: true
    },
    "telephone": {
      required: true
    },
    "email": {
      required: true,
      email: true
    },
    "country_id": {
      required: true
    },
    "zone_id": {
      required: true
    },
    "address_1": {
      required: true
    },
    "postcode": {
      required: true,
      digits: true
    }
  },
  highlight: function(element) {
    $(element).addClass("has-error");
  },
  unhighlight: function(element) {
    $(element).removeClass("has-error");
  },
  errorElement: "div",
  errorClass: "error-block",
  errorPlacement: function(error, element) {}
});
$("#shipping-form").validate({
  rules: {
    "country_id": {
      required: true
    },
    "zone_id": {
      required: true
    },
    "address_1": {
      required: true
    },
    "postcode": {
      required: true,
      digits: true
    }
  },
  highlight: function(element) {
    $(element).addClass("has-error");
  },
  unhighlight: function(element) {
    $(element).removeClass("has-error");
  },
  errorElement: "div",
  errorClass: "error-block",
  errorPlacement: function(error, element) {}
});

$(document).on("click", "#same-address", function(e) {
  var checked = $(this).is(":checked");
  if(checked) {
    $("#billing-same-address").attr("name", "shipping_address");
  } else {
    $("#billing-same-address").attr("name", "__shipping_address");
  }
});
//--></script>
<?php echo $form_message;?>
<?php echo $footer; ?>