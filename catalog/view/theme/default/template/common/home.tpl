<?php echo $header; ?>
<section id="intro" class="home-section section-intro">
    <div class="saber-image" data-0-start="transform: rotate(0)" data-40-start="transform: rotate(270deg)">
        <div class="saber-container">
            <div class="saber-photo"></div>
        </div>
    </div>
    <div class="sabermach-title">
        <h1>
            <span class="to-left logo-style">Saber</span>
            <span class="to-right logo-style">Mach</span>
        </h1>
        <?php if(!empty($slogan)):?>
        <div class="slogan">
        <?php foreach ($slogan as $class => $text) :?>
            <span class="<?php echo $class;?>"><?php echo $text;?></span>
        <?php endforeach;?>
        </div>
        <?php endif;?>
    </div>
    <div class="scroll-to-start">
        <a href="#why" class="action-label"><?php echo $text_scroll;?></a>
        <span class="description-label"><?php echo $text_to_start;?></span>
    </div>
</section>
<?php echo $content_top;?>
<section id="cta" class="section-cta">
    <div class="l-center">
        <div class="call-to-action">
            <svg viewBox="0 0 150 150" class="icon icon-bullet">
                <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_bullet"></use>
            </svg>
            <?php echo $text_get_today;?>
        </div>
        <a href="<?php echo $contact_url;?>#contact" class="btn-store">
            <svg viewBox="0 0 150 150" class="icon icon-shopping">
                <use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_mail"></use>
            </svg>
            <?php echo $text_contact_us;?>
        </a>
    </div>
</section>
<?php echo $content_bottom;?>
<div class="home-pop-up">
    <div class="close-btn">x</div>
    <div class="pop-heading tac">
        Promotions
    </div>
    <div class="pop-up-content">
        <ul class="bxslider">
            <li>
                    <div class="col-md-6 col-sm-6 col-lg-5 col-xs-12">
                        <img src="catalog/view/theme/default/img/pop-1.jpg" alt="">
                    </div>
                    <div class="col-md-6 col-sm-6 col-lg-7 col-xs-12">
                        <div class="pop-heading tac">
                            New Edition!!!
                        </div>
                        <div class="text-content">
                            Lorem ipsum dolor sit amet, consectetur adipisicing elit. Temporibus animi nostrum adipisci, non numquam error, cumque dolore iure eius commodi rerum alias aliquam repellat quasi autem est. Ipsam cum eveniet eius maiores dolorum dolore recusandae. Fugiat a quam, impedit laboriosam provident ad! Deserunt iste ad reiciendis voluptatem nemo molestias dicta architecto totam suscipit soluta inventore accusantium, harum tempore atque, ratione dolorem dolor, iusto quisquam natus ipsum magni perspiciatis enim delectus. Nemo reiciendis in a, natus suscipit beatae temporibus, commodi eveniet ullam, ad obcaecati quisquam nostrum laboriosam deleniti corporis. Vitae, odio. Reprehenderit est magni facilis consequatur minus libero, aspernatur doloribus aliquam beatae provident dolorem eligendi recusandae, distinctio amet pariatur molestiae neque non, 
                        </div>
                    </div>
            </li>
            <li>
                <img src="catalog/view/theme/default/img/pop-2.jpg" alt="">
                <div class="pop-heading">
                    New Edition!!!
                </div>
                <div class="text-content">
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Temporibus animi nostrum adipisci, non numquam error, cumque dolore iure eius commodi rerum alias aliquam repellat quasi autem est. Ipsam cum eveniet eius maiores dolorum dolore recusandae. Fugiat a quam, impedit laboriosam provident ad! Deserunt iste ad reiciendis voluptatem nemo molestias dicta architecto totam suscipit soluta inventore accusantium, harum tempore atque, ratione dolorem dolor, iusto quisquam natus ipsum magni perspiciatis enim delectus. Nemo reiciendis in a, natus suscipit beatae temporibus, commodi eveniet ullam, ad obcaecati quisquam nostrum laboriosam deleniti corporis. Vitae, odio. Reprehenderit est magni facilis consequatur minus libero, aspernatur doloribus aliquam beatae provident dolorem eligendi recusandae, distinctio amet pariatur molestiae neque non, repellendus ipsam voluptatibus officiis modi hic rem nisi? Saepe.
                </div>
            </li>
        </ul>
    </div>
</div>
    <script src="catalog/view/theme/default/js/home/vendor.js" type="text/javascript"></script>
    <script src="catalog/view/theme/default/js/home/app.js" type="text/javascript"></script>
    <script src="catalog/view/theme/default/js/home/restive.min.js" type="text/javascript"></script>
    <script>
    $( document ).ready(function() {
      $('body').restive({
        breakpoints: ['240', '320', '480', '640', '720', '960', '1280'],
        classes: ['rp_240', 'rp_320', 'rp_480', 'rp_640', 'rp_720', 'rp_960', 'rp_1280'],
        turbo_classes: 'is_mobile=mobi,is_phone=phone,is_tablet=tablet',
        force_dip: true
      });
      $('.bxslider').bxSlider({
            pager: false,
            adaptiveHeight: true,
            nextText:'<i class="fa fa-angle-right"></i>',
            prevText:'<i class="fa fa-angle-left"></i>'
        });
    });
  </script>
  <script src="catalog/view/theme/default/js/common.js" type="text/javascript"></script>
  <script src="catalog/view/theme/default/js/jquery.bxslider.min.js" type="text/javascript"></script>
  <!-- Configure Restive.JS -->
  <script>
    var isChrome = /Chrome/.test(navigator.userAgent) && /Google Inc/.test(navigator.vendor);
    if (!isChrome) {
      $('.saber-image').addClass('margin');
    } 
  </script>
<?php echo $footer; ?>