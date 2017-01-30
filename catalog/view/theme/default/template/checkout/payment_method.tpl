<div id="payment_inner">
    <?php if ($error_warning) : ?>
      <div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
    <?php endif; ?>
    <?php if ($payment_methods) : ?>
    <p class="text">Please select a payment method from the available options below:</p>
    <div class="tab-container">
      <ul class="tabs">
        <?php foreach ($payment_methods as $payment_method) : ?>
          <li class="tab"><a href="javascript:void(0)" data-tab_id="<?php echo str_replace([' ', '-'], '_', strtolower($payment_method['title'])); ?>" class="tab-link get_tab_link" style="font-size: 0.8rem;"><?php echo $payment_method['title']; ?></a></li>
        <?php endforeach; ?>
      </ul>
     

    <?php $i = 0; foreach ($payment_methods as $payment_method) : ?>
    <?php $i++; ?>
      <div id="<?php echo str_replace([' ', '-'], '_', strtolower($payment_method['title'])); ?>" class="tab-content payment_tab_content" <?php if($i == 1) echo 'style="display: block;"'; ?>>
        <div class="paypal-checkout <?php echo str_replace([' ', '-'], '_', strtolower($payment_method['title'])); ?>">
          
            <?php if($payment_method['code'] == 'pp_express') : ?>
              <div class="btn_wrap">
                <div class="paypal-btn">
                    Checkout with <img src="catalog/view/theme/default/img/paypal.png" alt="Paypal Logo">
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
</div>

<script>
  $(function() {

        $.ajax({
                url: 'index.php?route=checkout/payment_method/save',
                type: 'post',
                data: $('#payment_inner input[type=radio]:checked, #payment_inner input[type=checkbox]:checked, #payment_inner textarea'),
                dataType: 'json',
                success: function(json) {
                    // console.log(json);
                      $.ajax({
                          url: 'index.php?route=checkout/confirm',
                          dataType: 'html',
                          success: function(html) {
                              $('#submit_order').html(html);
                              $('.get_tab_link').first().trigger('click');
                          }
                      });
               }
            });

        $(document).on('click', '.get_tab_link', function() {
          var tab_id = $(this).data('tab_id');
          show_this_tab(tab_id);
        });

        function show_this_tab(tab_link) {
            var tab = $('#'+tab_link),
                tab_title = $('.get_tab_link[data-tab_id="' + tab_link + '"]'),
                tab_title_text = tab_title.text();
            $('.payment_tab_content').hide();
            $('.pay_method').removeAttr('checked');
            tab.find('.pay_method').prop('checked', 'checked')
            tab.fadeIn();
            tab_title.html(tab_title_text + ' <i class="fa fa-spinner fa-spin" aria-hidden="true"></i>');

            $.ajax({
                url: 'index.php?route=checkout/payment_method/save',
                type: 'post',
                data: $('#payment_inner input[type=radio]:checked, #payment_inner input[type=checkbox]:checked, #payment_inner textarea'),
                dataType: 'json',
                success: function(json) {
                      $.ajax({
                          url: 'index.php?route=checkout/confirm',
                          dataType: 'html',
                          success: function(html) {
                              var instruction = $(html).filter('#payment_instructions').html();
                              tab_title.html(tab_title_text);
                              if(typeof instruction !== 'undefined') {
                                  tab.find('.paypal-checkout').html(instruction);
                              }
                              $('#submit_order').html(html);
                          }
                      });
               }
            });
        };
  })
</script>


