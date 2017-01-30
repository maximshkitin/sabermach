<?php echo $header; ?>
<div class="content">
  <div class="page-header row">
    <h1 class="page-title"><span><?php echo $text_about_us;?></span></h1>
  </div>
  <?php if($about):?>
  <section id="about" class="page-section section-1">
    <div class="l-center row">
      <div class="col-3-1">
        <?php if(!empty($about->image)) :?>
        <img src="<?php echo $about->image;?>" class="img">
        <?php endif;?>
      </div>
      <div class="col-3-2">
        <h2 class="section-title"><?php echo $about->title;?></h2>
        <?php echo $about->description;?>
      </div>
    </div>
  </section>
  <?php endif;?>
  <?php if($faq):?>
  <section id="faq" class="page-section section-2">
    <div class="l-center row">
      <div class="col-3-2">
        <h2 class="section-title"><?php echo $faq->title;?></h2>
        <?php echo $faq->description;?>
      </div>
      <div class="col-3-1">
        <?php if(!empty($faq->image)) :?>
        <img src="<?php echo $faq->image;?>" class="img">
        <?php endif;?>
      </div>
    </div>
  </section>
  <?php endif;?>
  <?php if($terms):?>
  <section id="tandc" class="page-section section-3">
    <div class="l-center row">
      <div class="col-4-1">
        <div class="header">
          <h2 class="entry-title"><?php echo $terms->title;?></h2>
          <div class="entry-meta">
            <svg viewBox="0 0 150 150" class="icon icon-info">
              <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_info"></use>
            </svg>
            <?php echo $text_last_updated;?>: <strong><?php echo date('jS M Y', strtotime($terms->updated));?></strong>
          </div>
        </div>
      </div>
      <div class="col-4-3">
      <?php echo $terms->description;?>
      </div>
    </div>
  </section>
  <?php endif;?>
  <section id="contact" class="page-section section-contact-form">
    <div class="l-center">
      <header class="section-header">
        <h2 class="heading"><?php echo $text_contact_us;?></h2>
          <div class="sub-heading">
            <svg viewBox="0 0 150 150" class="icon icon-shine">
              <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_shine"></use>
            </svg>
            <?php echo $text_feedback_enquiries;?>
            <svg viewBox="0 0 150 150" class="icon icon-shine">
              <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_shine"></use>
            </svg>
          </div>
      </header>
    </div>
    <div class="l-center row">
      <div class="col-4-3">
      <?php if ($comment) {
        echo $comment;
      } ?>
        <form action="<?php echo $action; ?>#contact" method="post" enctype="multipart/form-data" id="form" class="contact-form">
          <?php if($text_message):?>
            <!-- <div class="text-success"><?php echo $text_message;?></div> -->
          <?php endif;?>
          <?php if ($error_name) : ?>
            <div class="text-danger"><?php echo $error_name; ?></div>
          <?php endif; ?>
          <?php if ($error_email) : ?>
            <div class="text-danger"><?php echo $error_email; ?></div>
          <?php endif; ?>
          <?php if ($error_phone) : ?>
            <div class="text-danger"><?php echo $error_phone; ?></div>
          <?php endif; ?>
          <?php if ($error_enquiry) : ?>
            <div class="text-danger"><?php echo $error_enquiry; ?></div>
          <?php endif; ?>
          <div class="input-2">
            <input type="text" name="name" id="name" value="<?php echo $name;?>" placeholder="<?php echo $entry_name; ?> ...">
            <input type="email" name="email" id="email" value="<?php echo $email;?>" placeholder="<?php echo $entry_email; ?> ...">
            <input type="text" name="phone" id="phone" value="<?php echo $phone;?>" placeholder="<?php echo $entry_phone; ?> ...">
          </div>
            <textarea name="enquiry" id="message" rows="10" placeholder="<?php echo $entry_enquiry; ?> ..." ><?php echo $enquiry;?></textarea>
            <?php echo $captcha; ?>
            <button id="send" type="submit" class="btn" name="submit">
              <svg viewBox="0 0 150 150" class="icon icon-mail">
                <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_mail"></use>
              </svg>
                  Submit
            </button>
        </form>
      </div>
      <div class="col-4-1">
        <?php if($telephone):?>
        <p><?php echo $text_reach_us;?>:</p>
        <span class="featured-phone"><svg viewBox="0 0 150 150" class="icon icon-phone">
          <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_phone"></use>
        </svg><?php echo $telephone; ?></span>
        <?php endif;?>
        <p><?php echo $text_located_at;?>: </p>
        <?php if($address) {
          $address = explode("<br />", $address);
          foreach ($address as $text) {
            echo '<p>'.$text.'</p>';
          }
        }?>
      </div>
    </div>
  </section>
</div>
<?php echo $form_message;?>
<?php echo $footer; ?>
