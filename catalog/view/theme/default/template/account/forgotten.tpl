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
            <?php if ($error_warning) : ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
            <?php endif; ?>
            <div class="input-field">
              <label for=""><?php echo $entry_email; ?></label>
              <input class="dark-input" type="email" name="email" value="<?php echo $email; ?>">
            </div>
            <hr class="dark">
            <div class="input-field submit clearfix">
              <a class="to-sign-up" href="<?php echo $back; ?>"><?php echo $button_back; ?></a>
              <input class="submit-button" type="submit" value="<?php echo $button_continue; ?>">
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