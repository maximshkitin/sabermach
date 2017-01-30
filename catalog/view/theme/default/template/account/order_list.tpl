<?php echo $header; ?>
  <div class="user-page order order-list" id="content">
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
<!--           <div class="note">
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
              <div id="orders_table">
              <div class="order-info clearfix">
                <h1 class="content-heading">
                  <i class="fa fa-shopping-cart"></i>
                  Orders
                </h1>
                <?php if ($success) : ?>
                <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
                <?php endif; ?>
                <?php if ($error_warning) : ?>
                <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
                <?php endif; ?>

                <ul>
                  <li<?php echo ($filter == 'active') ? ' class="active"' : '';?>>
                    <a href="<?php echo $actite;?>">Active Orders</a>
                  </li>
                  <li<?php echo ($filter == 'unpaid') ? ' class="active"' : '';?>>
                    <a href="<?php echo $unpaid;?>">Unpaid Orders</a>
                  </li>
                  <li<?php echo ($filter == 'past') ? ' class="active"' : '';?>>
                    <a href="<?php echo $past;?>">Past Orders</a>
                  </li>
                </ul>
              </div>
              <?php if ($orders) : ?>
              <div class="table-wrapper">
                <table>
                  <thead>
                    <tr>
                      <th class="tal">Order ID</th>
                      <th>Date</th>
                      <th>Total</th>
                      <th>Payment</th>
                      <th>Invoice</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php foreach ($orders as $order) : ?>
                    <tr>
                      <td>
                        <a href="<?php echo $order['view']; ?>">#<?php echo $order['order_id']; ?></a>
                        <div class="status <?php echo $order['status_color'];?>">
                          <span>pending</span>
                        </div>
                      </td>
                      <td>
                        <?php echo $order['date_added']; ?>
                      </td>
                      <td><?php echo $order['total']; ?></td>
                      <?php if(!empty($order['payment'])):?>
                      <td class="pay-status paid">
                        <p>
                          <i class="fa fa-check-circle-o"></i>
                          paid
                        </p>
                        <span>
                          on
                          <span class="date">
                            <?php echo date('M n, Y', strtotime($order['payment']['date_add']));?>
                          </span>
                        </span>
                      </td>
                      <?php else:?>
                      <td class="pay-status unpaid">
                        <p>
                          <i class="fa fa-info-circle"></i>
                          unpaid
                        </p>
                        <a href="javascript:void(0)" class="pay_now_link" data-order_id="<?php echo $order['order_id']; ?>">
                          Pay now
                        </a
                      </td>
                      <?php endif;?>
                      <td>
                        <ul class="clearfix">
                          <li><a href="<?php echo $order['download'];?>">
                            <i class="fa fa-download"></i>
                          </a></li>
                          <li><a href="#" data-info="<?php echo $order['view']; ?>" class="print">
                            <i class="fa fa-print"></i>
                          </a></li>
                          <li><a href="<?php echo $order['pdf'];?>" target="_blank">
                            <i class="fa fa-file-pdf-o"></i>
                          </a></li>
                        </ul>
                      </td>
                    </tr>
                    <?php endforeach;?>
                  </tbody>
                </table>
              </div>
              <div class="empty"></div>
              <?php if($pagination):?>
              <hr class="dark">
              <?php echo $pagination; ?>
              <?php endif;?>
              <?php else:?>
              <div class="empty"></div>
              <div class="info-box">
                <p>
                  No active order. Buy product in the <a href="<?php echo $store;?>">store</a>  now, or if you have already picked saber(s) before then <a href="<?php echo $cart;?>">view</a>  cart to proceed to checkout.
                </p>
              </div>
              <?php endif;?>
        </div>



          <div id="pay_now_block" style="display: none;">
              <div class="order-info clearfix">
                <h1 class="content-heading">
                  <i class="fa fa-shopping-cart"></i>
                  Pay Now
                </h1>
              </div>
            <?php if ($payment_methods) : ?>
            <p class="text">Please select a payment method for order #<span class="order_num"></span> from the available options below:</p>
            <div class="tab-container">
              <ul class="tabs">
                <?php foreach ($payment_methods as $payment_method) : ?>
                  <li class="tab"><a href="javascript:void(0)" data-tab_id="<?php echo str_replace([' ', '-'], '_', strtolower($payment_method['title'])); ?>" data-payment_name="<?php echo $payment_method['title']; ?>" data-payment_code="<?php echo $payment_method['code']; ?>" class="tab-link get_tab_link" style="font-size: 0.8rem;"><?php echo $payment_method['title']; ?></a></li>
                <?php endforeach; ?>
              </ul>
            <?php $i = 0; foreach ($payment_methods as $payment_method) : ?>
            <?php $i++; ?>
              <div id="<?php echo str_replace([' ', '-'], '_', strtolower($payment_method['title'])); ?>" class="tab-content payment_tab_content" <?php if($i == 1) echo 'style="display: block;"'; ?>>
                <?php if($i == 1) {
                 $first_payment_name = $payment_method['title'];
                 $first_payment_code = $payment_method['code'];
                 } ?>
                <div class="paypal-checkout <?php echo str_replace([' ', '-'], '_', strtolower($payment_method['title'])); ?>">
                  
                    <?php if($payment_method['code'] == 'pp_express') : ?>
                      <div class="btn_wrap">
                        <div class="paypal-btn">
                            Pay now with <img src="catalog/view/theme/default/img/paypal.png" alt="Paypal Logo">
                         </div>
                    </div>
                    <?php endif; ?>
                   
                  <div style="display: none;">
                    <?php if ($i == 1) : ?>
                    <input type="radio" class="pay_method" name="payment_method" value="<?php echo $payment_method['code']; ?>" checked="checked" />
                    <?php else : ?>
                    <input type="radio" class="pay_method" name="payment_method" value="<?php echo $payment_method['code']; ?>" />
                    <?php endif;  ?>
                  </div>
                </div>
                <?php if($payment_method['code'] == 'bank_transfer') : ?>
                  <section class="reply">
                      <hr>
                      <h4 class="content-subheading">
                          <i class="fa fa-info-circle" aria-hidden="true"></i> Sumbit bank transfer details
                      </h4>
                      <div class="comment-box clearfix">
                          <div class="comment-text" style="margin-left: 0;">
                              <form action="" id="reply-comment">
                                  <textarea name="text" id="comment-text" rows="6" required></textarea>
                                  <hr class="dark">
                                  <div class="submit-line clearfix">
                                      <div class="pinned-images">
                                          <div class="item add-img review-add">
                                              <div>
                                                  <i class="fa fa-picture-o"></i>
                                              </div>
                                              add image
                                          </div>
                                      </div>
                                      <div class="submit-wrap">
                                          <div>
                                              <div class="btn_ico">
                                                  <i class="fa fa-paper-plane"></i>
                                              </div>
                                              <input class="submit-button" type="submit" value="Submit">
                                          </div>
                                      </div>
                                  </div>
                                  <input type="hidden" name="bank_transfer_order_id" id="bank_transfer_order_id" value="">
                              </form>
                          </div>
                      </div>
                  </section>
                <?php endif; ?>
                <div class="tab-footer">
                  <svg viewBox="0 0 150 150" class="icon icon-padlock">
                    <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_padlock"></use>
                  </svg>
                  SaberMach uses industry standard encryption to protect the confidenciality of your personal information.
                </div><!-- .tab-footer -->
              </div><!-- .tab-content -->
            <?php endforeach; ?>
            </div>
            <?php endif; ?>
            <input type="checkbox" hidden name="agree" value="1" checked="checked" />
            <textarea hidden name="comment"></textarea>
            <div class="pay_alert"></div>
            <div class="pull-right">
              <br>
              <button id="back-to-list" class="btn btn--transparent">
                <div class="border"></div>
                <span class="text">Back</span>
              </button>
              <button id="confirm_pay_now" class="btn">
                <div class="border"></div>
                <span class="text">Confirm</span>
              </button>
            </div>
          </div>




        </section>

          </div>
        </section>
      </div>
    </div>
  </div>
  <div id="modal">
    <div class="loader-icon"></div>
  </div>
  <script src="catalog/view/theme/default/js/print.js"></script>
  <script src="catalog/view/theme/default/js/validation/jquery.validate.min.js" type="text/javascript"></script>
  <script type="text/javascript"><!--
  $('.print').on('click', function(e) {
    e.preventDefault();
    var url = $(this).data('info');
    $.get(url, { "_": $.now() }, function(data, status){
        var page = $(data);
        page.find('#content-table').print({
          globalStyles: false,
          iframe: true,
          noPrintSelector: ".no-print",
          append: null,
          prepend: null,
          manuallyCopyFormValues: true,
          deferred: $.Deferred(),
          timeout: 750,
          doctype: '<!doctype html>'
        });
    });
  });
  //--></script>
  <script>
    $(function() {

      function show_this_tab(tab_link) {
          var tab = $('#'+tab_link),
              tab_title = $('.get_tab_link[data-tab_id="' + tab_link + '"]'),
              tab_title_text = tab_title.text(),
              payment_name = $('.get_tab_link[data-tab_id="' + tab_link + '"]').attr('data-payment_name'),
              payment_code = $('.get_tab_link[data-tab_id="' + tab_link + '"]').attr('data-payment_code');
          var data = {
            payment_code: payment_code
          }
          
          $('#confirm_pay_now').attr('data-payment_name', payment_name).attr('data-payment_code', payment_code);
          $('.payment_tab_content').hide();
          $('.pay_method').removeAttr('checked');
          tab.find('.pay_method').prop('checked', 'checked')
          tab.fadeIn();
          tab_title.html(tab_title_text + ' <i class="fa fa-spinner fa-spin" aria-hidden="true"></i>');

          $.ajax({
              url: 'index.php?route=account/order/ajax_load_payment',
              type: 'post',
              dataType: 'html',
              data: data,
              success: function(html) {
                  var instruction = $(html).filter('#payment_instructions').html();
                  tab_title.html(tab_title_text);
                  if(typeof instruction !== 'undefined') {
                      tab.find('.paypal-checkout').html(instruction);
                  }
              }
          });
      };

      $('.get_tab_link').on('click', function() {
        var tab_id = $(this).data('tab_id');
        show_this_tab(tab_id);
      });

      $('#confirm_pay_now').on('click', function() {
        var order_id = $(this).attr('data-order_id'),
            payment_name = $(this).attr('data-payment_name'),
            payment_code = $(this).attr('data-payment_code'),
            data = {
              order_id: order_id,
              payment_name: payment_name,
              payment_code: payment_code
            },
            btn = $('#confirm_pay_now .text');

        btn.html('Confirm <i class="fa fa-spinner fa-spin" aria-hidden="true"></i>');
        $.ajax({
                url: 'index.php?route=account/order/ajax_pay_now',
                type: 'post',
                data: data,
                dataType: 'json',
                success: function(json) {
                    btn.html('Confirm');
                    if(json.message == 'Success') {
                      $('.pay_alert').html('<span style="color: green";>Successfully submitted! Payment will be updated within 1-2 working days.</span>');
                    } else if(json.message == 'Fail'){
                       $('.pay_alert').html('<span style="color: red";>' + json.message + '</span>'); 
                    }
                    setTimeout(function(){
                        $('.pay_alert').html('');
                        $('#back-to-list').trigger('click');
                    }, 5000)
               }
            });
      });

      $('.pay_now_link').on('click', function() {
          var order_id = $(this).attr('data-order_id');

          $('#confirm_pay_now').attr('data-payment_name', '<?php echo $first_payment_name; ?>').attr('data-payment_code', '<?php echo $first_payment_code; ?>').attr('data-order_id', order_id);
          $('#pay_now_block .order_num').text(order_id);
          $('#pay_now_block #bank_transfer_order_id').val(order_id);
          $('#orders_table').fadeOut();
          $('#pay_now_block').show();
          $('.get_tab_link').first().trigger('click');
      });

      $('#back-to-list').on('click', function() {
          $('#confirm_pay_now').attr('data-order_id', '').attr('data-payment_name', '').attr('data-payment_code', '');
          $('#pay_now_block .order_num').text('');
          $('#pay_now_block #bank_transfer_order_id').val('');
          $('#comment-text').val('');
          $('.submit-wrap .submit-button').val('SUBMIT');
          $('.pinned-images').html('<div class="item add-img review-add"><div><i class="fa fa-picture-o"></i></div>add image</div>');
          $('#pay_now_block').fadeOut();
          $('#orders_table').show();
      });

    })


    $(function(){
        $('.add-img.review-add').click(function(e){
          e.preventDefault();
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
                url: 'index.php?route=tool/upload/contact',
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
                    $('#reply-comment .pinned-images').prepend('<div class="item"><div><input type="hidden" name="files[]" value="' + json['attachment'] + '"/><img src="' + json['image'] + '" alt=""></div><a href="#" class="remove-mg-input"><i class="fa fa-close"></i> remove</a></div>');
                  }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                  alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
              });
            }
          }, 500);
        });
        $(document).on('click', '.remove-mg-input', function(e){
            e.preventDefault();
            $(this).parent().remove();
        });
        $("#reply-comment").on("submit", function(e) {
          e.preventDefault();
          var form = $(this);
          form.validate();
          if(form.valid()) {
            $.ajax({
              url: '/index.php?route=account/order/submit_bank_transfer_details',
              type: 'post',
              data: form.serialize(),
              dataType: 'json',
              beforeSend: function() {
                $('.btn_ico').html('<i class="fa fa-spinner fa-spin" aria-hidden="true"></i>');
              },
              success: function(json) {
                $('.btn_ico').html('<i class="fa fa-paper-plane"></i>');
                if(json.success) {
                  $('.submit-wrap .submit-button').val('SAVED');
                }
              }
            });
          }
          return false;
        });
        $("#reply-comment").validate({
          rules: {
            "text": {
              required: true
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
    });


  </script>
<?php echo $footer; ?>
