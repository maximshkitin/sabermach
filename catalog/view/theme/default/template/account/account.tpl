<?php echo $header; ?>
  <div class="user-page" id="content">
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
          <!-- <div class="note">
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
          <h1 class="content-heading"><i class="fa fa-tachometer"></i> My Account</h1>
          <?php if ($success) : ?>
          <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
          <?php endif; ?>
          <?php if ($error_warning) : ?>
          <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
          <?php endif; ?>
          <div class="content-subheading">Hello, <?php echo $firstname;?>!</div>
          <hr class="dark">
          <p>From your account dashboard you can view your <a href="<?php echo $order; ?>">active orders</a>.</p>
          <p>Visit <a href="<?php echo $edit; ?>">account details</a>  to manage addresses and your basic information.</p>
          <div class="user-info row">
            <section class="col-md-6">
              <h3 class="content-subheading">Overview</h3>
              <hr class="dark">
              <p>
                <span><?php echo $active_total;?></span> active orders
              </p>
              <p>
                <span><?php echo $unpaid_total;?></span> unpaid invoice <i class="fa fa-info-circle red"></i>
              </p>
              <p>
                <span><?php echo $past_total;?></span> past orders
              </p>
            </section>
            <section class="col-md-6 general">
              <h3 class="content-subheading">General Information</h3>
              <hr class="dark">
              <p>
                <i class="fa fa-user"></i> Name: <?php echo $firstname . ' ' .$lastname;?>
              </p>
              <?php if(!empty($payment_address) && !empty($payment_address['address_1'])):?>
              <p>
                <i class="fa fa-map-marker"></i> Billing Address: <?php echo $payment_address['address_1'] . ', ' . (!empty($payment_address['zone_code']) ? $payment_address['zone_code'] . ', ' : '') . $payment_address['iso_code_2'];?>.
              </p>
              <?php endif;?>
              <?php if(!empty($shipping_address) && !empty($shipping_address['address_1'])):?>
              <p>
                <i class="fa fa-truck"></i>
                Shipping Address: <?php echo $shipping_address['address_1'] . ', ' . (!empty($shipping_address['zone_code']) ? $shipping_address['zone_code'] . ', ' : '') . $shipping_address['iso_code_2'];?>.
              </p>
              <?php endif;?>
              <hr class="dark">
              <p>
                <a href="<?php echo $edit; ?>">Click here</a>
                to view details or update information
              </p>
            </section>
          </div>
        </section>
      </div>
    </div>
  </div>
  <div id="modal">
    <div class="loader-icon"></div>
  </div>
<?php echo $form_message;?>
<?php echo $footer; ?> 