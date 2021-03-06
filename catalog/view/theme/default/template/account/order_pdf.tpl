
  <style>

    body {
      background-color: #fff; 
        margin: 0; 
        padding: 0; 
        font-family: roboto, helvetica, arial, sans-serif;
        color: #545454;
        font-size: 13px;
    }
    a {
      text-decoration: none;
    }
    a:hover {
      text-decoration: underline;
    }
    html {
      width: 100%;
    }
    table[class="header"] {
      background: #c78c43;
    }
    table[class="info-table"] {
      font-size: 13px !important;
    }
    td[class="right-border"] {
      border-right: 1px solid #fff;
    }
    table[class="content-table"] {
      margin: 0 auto;
    }
    td[class="heading"] {
      color: #999;
        font-weight: 400;
        text-align: center;
        text-transform: uppercase;
    }
    span[class="orange"]{
      color: #dfb16b;
    }
    td[class="orange"] {
      padding-top: 20px;
      color: #dfb16b;
    }
    td[class="bottom-border__grey"] {
      padding-top: 15px;
    }
    table[class="order"] {
      border-radius: 5px;
      overflow: hidden;
    }
    td[class="status-line"] {
      text-transform: uppercase;
      padding-bottom: 15px;
    }
    th[class="order-h"],
    td[class="order-f"] {
      color: #fff;
      text-transform: uppercase;
      padding-top: 15px;
      padding-bottom: 15px;
      font-weight: 700;
    }
    table[class="order"] tfoot td {
      padding-left: 25px;
      padding-right: 25px;
    }
    table[class="order"] th,
    table[class="order"] tbody td {
      border-right: 1px solid #fff;
    }
    table[class="order"] tbody td {
      padding: 15px;
    }
    table[class="order"] tbody tr:nth-child(2n+1) {
      background-color: #f7fafc;
    }
    table[class="order"] tbody tr:nth-child(2n) {
      background-color: #f0f2f5;
    }
    td[class="pr-30"] {
      padding-right: 30px;
    }
    table[class="info-table"] td {
      padding-top: 10px;
    }
    img {
      vertical-align: middle;
    }
    table[class="order"] th:last-child, 
    table[class="order"] td:last-child {
      border-right: 0;
    }
    span[class="paid"],
    span[class="unpaid"] {
      padding-left: 10px;
    }
  </style>
          <table class="content-table" id="content-table" bgcolor="#fff" width="100%" cellpadding="0" cellspacing="0">
            <tbody>
              <tr>
                <td class="heading" align="center" width="100%">
                <?php if ($invoice_no) : ?>
                  Invoice <span class="orange">#<?php echo $invoice_no;?></span>
                <?php else: ?>
                  Order <span class="orange">#<?php echo $order_id; ?></span>
                <?php endif;?>
                </td>
              </tr>
              <tr>
                <td width="100%" height="30">&nbsp;</td>
              </tr>
              <tr>
                <td cellpadding="0" cellspacing="0" width="100%">
                  <table cellpadding="0" cellspacing="0" width="100%">
                    <tbody>
                      <tr>
                        <td cellpadding="0" cellspacing="0" width="45">&nbsp;</td>
                        <td cellpadding="0" cellspacing="0">
                          <table class="info-table" cellpadding="0" cellspacing="0" width="400">
                            <tbody>
                              <tr>
                                <td cellpadding="0" cellspacing="0" class="orange">
                                  <strong>To:</strong>
                                </td>
                              </tr>
                              <tr>
                                <td cellpadding="0" cellspacing="0">
                                  <strong><?php echo $payment_address['firstname'] . ' ' . $payment_address['lastname'];?></strong>
                                </td>
                              </tr>
                              <tr>
                                <td cellpadding="0" cellspacing="0">
                                  <table cellpadding="0" cellspacing="0">
                                    <tbody>
                                      <tr>
                                        <td class="pr-30" cellpadding="0" cellspacing="0">Phone:</td>
                                        <td cellpadding="0" cellspacing="0"><strong><?php echo $telephone;?></strong></td>
                                      </tr>
                                      <tr>
                                        <td class="pr-30" cellpadding="0" cellspacing="0">Email:</td>
                                        <td cellpadding="0" cellspacing="0"><strong><?php echo $email;?></strong></td>
                                      </tr>
                                    </tbody>
                                  </table>
                                </td>
                              </tr>
                              <tr>
                                <td class="bottom-border__grey"></td>
                              </tr>
                            </tbody>
                          </table>
                          <table class="info-table" cellpadding="0" cellspacing="0" width="400">
                            <tbody>
                              <tr>
                                <td cellpadding="0" cellspacing="0" class="orange">
                                  <strong>Billing Address</strong>
                                </td>
                              </tr>
                              <tr>
                                <td cellpadding="0" cellspacing="0">
                                  <img src="catalog/view/theme/default/img/map-marker.png" alt="">
                                  <?php echo $payment_address['postcode'] . ' ' . ((!empty($payment_address['address_1'])) ? $payment_address['address_1'] . ', ' : '') . ((!empty($payment_address['zone'])) ? $payment_address['zone'] . ', ' : '') .  $payment_address['country_code'];?>.
                                </td>
                              </tr>
                              <tr>
                                <td class="bottom-border__grey"></td>
                              </tr>
                            </tbody>
                          </table>
                          <table class="info-table" cellpadding="0" cellspacing="0" width="400">
                            <tbody>
                              <tr>
                                <td cellpadding="0" cellspacing="0" class="orange">
                                  <strong>Shipping Address</strong>
                                </td>
                              </tr>
                              <tr>
                                <td cellpadding="0" cellspacing="0">
                                  <img src="catalog/view/theme/default/img/truck.png" alt="">
                                 <?php echo $shipping_address['postcode'] . ' ' . ((!empty($shipping_address['address_1'])) ? $shipping_address['address_1'] . ', ' : '') . ((!empty($shipping_address['zone'])) ? $shipping_address['zone'] . ', ' : '') .  $shipping_address['country_code'];?>.
                                </td>
                              </tr>
                              <tr>
                                <td class="bottom-border__grey"></td>
                              </tr>
                            </tbody>
                          </table>
                        </td>
                        <td width="150" align="right" valign="top">
                          <a href="<?php echo $base;?>">
                            <img width="150px" height="150px" src="<?php echo $logo;?>" alt="">
                          </a>
                        </td>
                        <td cellpadding="0" cellspacing="0" width="45">&nbsp;</td>
                      </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr>
                <td width="100%" height="60">&nbsp;</td>
              </tr>
              <tr>
                <td width="100%" cellpadding="0" cellspacing="0">
                  <table width="100%" cellpadding="0" cellspacing="0">
                    <tbody>
                      <tr>
                        <td class="status-line" width="45">&nbsp;</td>
                        <td class="status-line" align="left">
                          <img src="catalog/view/theme/default/img/hash-y.png" alt="">
                          Order / Invoice <span class="orange"><strong>#<?php if ($invoice_no) {echo $invoice_no;}else{echo $order_id;} ?></strong></span>
                        </td>
                        <td class="status-line" align="center">
                          <img src="catalog/view/theme/default/img/calendar.png" alt="">
                          Data Published <span class="orange"><strong><?php echo $date_added;?></strong></span>
                        </td>
                        <td class="status-line" align="right">
                          Payment Status 
                          <?php if(empty($payment)):?>
                          <span class="unpaid">
                            <strong style="color: #ed7253;">
                              <img src="catalog/view/theme/default/img/exclam-red.png" alt="">
                              Unpaid
                            </strong>
                          </span>
                          <?php else:?>
                          <span class="paid">
                            <strong style="color: #dfb16b;">
                              <img src="catalog/view/theme/default/img/check-y.png" alt="">
                              Paid
                            </strong>
                          </span>
                          <?php endif;?> 
                        </td>
                        <td class="status-line" width="45">&nbsp;</td>
                      </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table cellpadding="0" cellspacing="0" width="100%">
                    <tbody>
                      <tr>
                        <td width="45">&nbsp;</td>
                        <td>
                          <table class="order" cellpadding="0" cellspacing="0" width="100%">
                            <thead>
                              <tr>
                                <th class="order-h" bgcolor="#dfb16b">Sku</th>
                                <th class="order-h" bgcolor="#dfb16b">Item description</th>
                                <th class="order-h" bgcolor="#dfb16b">QTY</th>
                                <th class="order-h" bgcolor="#dfb16b">Price / Unit</th>
                                <th class="order-h" bgcolor="#dfb16b">Total</th>
                              </tr>
                            </thead>
                            <tbody>
                            <?php if(!empty($products)):?>
                            <?php foreach ($products as $product) :?>
                              <tr>
                                <td align="center">
                                  <?php echo $product['sku'];?>
                                </td>
                                <td>
                                  <strong>
                                    <?php echo $product['name'];?>
                                  </strong>
                                  - <?php echo $product['hilts'];?> (<?php echo $product['colors'];?>)
                                </td>
                                <td align="center"><strong><?php echo $product['quantity'];?></strong></td>
                                <td align="center"><?php echo $product['price'];?></td>
                                <td align="right"><?php echo $product['total'];?></td>
                              </tr>
                            <?php endforeach;?>
                            <?php endif;?>

                              <tr>
                                <td colspan="3"></td>
                                <td>
                                  <?php foreach ($totals as $total) { ?>
                                  <?php echo $total['title']; ?><br />
                                  <?php } ?>
                                </td>
                                <td align="right">
                                  <strong>
                                    <?php foreach ($totals as $total) { ?>
                                    <?php echo $total['text']; ?><br />
                                    <?php } ?>
                                  </strong>
                                </td>
                              </tr>
                            </tbody>
                            <tfoot>
                              <tr>
                                <td class="order-f" bgcolor="#dfb16b">Invoice total</td>
                                <td class="order-f" bgcolor="#dfb16b" colspan="3">&nbsp;</td>
                                <td class="order-f" bgcolor="#dfb16b" align="right">
                                  <?php echo $order_total;?>
                                </td>
                              </tr>
                            </tfoot>
                          </table>
                        </td>
                        <td width="45">&nbsp;</td>
                      </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
            </tbody>
          </table>