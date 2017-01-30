<?php echo $header; ?>
<div class="main">
  <main class="l-center content">
    <div class="col-left">
      <div class="title">
        <span class="logo-sm"><?php echo $name;?></span>
        <span class="action">
          <svg viewBox="0 0 150 150" class="icon icon-shine">
            <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_shine"></use>
          </svg> Your cart is empty
          <svg viewBox="0 0 150 150" class="icon icon-shine">
            <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_shine"></use>
          </svg>
        </span>
      </div>
      <div class="checkout-calculator">
        <div class="saber-footer">
          <div class="get-help">
            <svg viewBox="0 0 150 150" class="icon icon-info">
              <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_info"></use>
            </svg>
            Get help buying. <strong><?php echo $help_email;?><?php echo (!empty($help_phone) && !empty($help_email)) ? ' • ' : '';?><?php echo $help_phone;?></strong>
          </div>
        </div>
      </div>
    </div>
    <!-- <div class="col-right">
      <dl class="store-steps">
        <dt id="address-info">
          <svg viewBox="0 0 150 150" class="icon icon-shipping">
            <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_shipping"></use>
          </svg> Billing & shipping
        </dt>
        <dt id="payment-selection">
          <svg viewBox="0 0 150 150" class="icon icon-card">
            <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_card"></use>
          </svg> Payment
        </dt> 
      </dl>
    </div> -->
  </main> 
</div>
<?php echo $footer; ?>