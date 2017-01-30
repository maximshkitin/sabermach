<?php echo $header; ?>
<div class="login" id="content">
  <section class="wrapper">
    <div class="container-form">
      <div class="form-toggle log-in">
        <div class="chrome-heading">
          <?php echo $button_login; ?>
        </div>
        <hr class="dark">
        <div class="form-wrapper">
          <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
            <?php if ($success) : ?>
            <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
            <?php endif; ?>
            <?php if ($error_warning) : ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
            <?php endif; ?>
            <div class="input-field">
              <label for=""><?php echo $entry_email; ?></label>
              <input class="dark-input" type="email" name="email" value="<?php echo $email; ?>">
            </div>
            <div class="input-field">
              <label for=""><?php echo $entry_password; ?></label>
              <input class="dark-input" name="password" type="password" value="<?php echo $password; ?>">
            </div>
            <?php if(!empty($providers)):?>
            <hr class="dark">
            <div class="login-btns ulogin_accounts">
              <?php foreach ($providers as $providers => $url) :?>
              <?php if($providers == 'Facebook'):?>
              <a href="<?php echo $url;?>" class="login-btn fb-btn">
                <i class="fa fa-facebook-square"></i>
                Login with Facebook
              </a>
              <?php elseif($providers == 'Google'):?>
              <a href="<?php echo $url;?>" class="login-btn gp-btn">
                <i class="fa fa-google-plus-square"></i>
                Login with Google+
              </a>
              <?php endif;?>
              <?php endforeach;?>
            </div>
            <?php endif;?>
            <hr class="dark">
            <div class="input-field submit clearfix">
              <a class="to-sign-up" href="<?php echo $register; ?>"><?php echo $text_don_have_accaunt;?></a>
              <input class="submit-button" type="submit" value="<?php echo $button_login; ?>">
            </div>
          </form>
        </div>
      </div>
    </div>
  </section>
</div>
<div id="modal">
  <div class="loader-icon"></div>
</div>
<?php echo $footer; ?>