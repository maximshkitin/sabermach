<?php echo $header; ?>
<div class="login" id="content">
  <section class="wrapper">
    <div class="container-form">
      <div class="form-toggle log-in">
        <div class="chrome-heading">
          <?php echo $heading_title; ?>
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
              <label for="firstname"><?php echo $entry_firstname; ?></label>
              <input class="dark-input" type="text" id="firstname" name="firstname" value="<?php echo $firstname; ?>">
              <?php if ($error_firstname) { ?>
              <div class="text-danger"><?php echo $error_firstname; ?></div>
              <?php } ?>
            </div>
            <div class="input-field">
              <label for="lastname"><?php echo $entry_lastname; ?></label>
              <input class="dark-input" type="text" id="lastname" name="lastname" value="<?php echo $lastname; ?>">
              <?php if ($error_lastname) { ?>
              <div class="text-danger"><?php echo $error_lastname; ?></div>
              <?php } ?>
            </div>
            <div class="input-field">
              <label for="email"><?php echo $entry_email; ?></label>
              <input class="dark-input" type="email" id="email" name="email" value="<?php echo $email; ?>">
              <?php if ($error_email) { ?>
              <div class="text-danger"><?php echo $error_email; ?></div>
              <?php } ?>
            </div>
            <div class="input-field">
              <label for="telephone"><?php echo $entry_telephone; ?></label>
              <input class="dark-input" id="telephone" name="telephone" value="<?php echo $telephone; ?>">
              <?php if ($error_telephone) { ?>
              <div class="text-danger"><?php echo $error_telephone; ?></div>
              <?php } ?>
            </div>
            <div class="input-field">
              <label for=""><?php echo $entry_password; ?></label>
              <input class="dark-input" name="password" type="password" value="<?php echo $password; ?>">
              <?php if ($error_password) { ?>
              <div class="text-danger"><?php echo $error_password; ?></div>
              <?php } ?>
            </div>
            <div class="input-field">
              <label for="confirm"><?php echo $entry_confirm; ?></label>
              <input class="dark-input" type="password" id="confirm" name="confirm" value="<?php echo $confirm; ?>">
              <?php if ($error_confirm) { ?>
              <div class="text-danger"><?php echo $error_confirm; ?></div>
              <?php } ?>
            </div>
            <?php echo $captcha; ?>
            <hr class="dark">
            <div class="input-field submit clearfix">
              <a class="to-sign-up" href="<?php echo $login; ?>">Already have an account</a>
              <input class="submit-button" type="submit" value="<?php echo $text_register; ?>">
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