
<?php foreach ($shipping_methods as $shipping_method) { ?>
<?php if (!$shipping_method['error']) { ?>
<?php $i = 0;?>
<?php foreach ($shipping_method['quote'] as $quote) { ?>
    <?php if ($quote['code'] == $code || !$code) { ?>
    <?php $code = $quote['code']; ?>
    <input type="radio" class="hidden" name="shipping_method" value="<?php echo $quote['code']; ?>"<?php echo ($i == 0) ? ' checked="checked"' : '';?>/>
    <?php $i++;?>
    <?php } ?>
<?php } ?>
<?php } ?>
<?php } ?>

