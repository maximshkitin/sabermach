<section id="carousel" class="home-section section-carousel">
  <div class="l-center">
    <?php if(!empty($title) || !empty($description)) :?>
    <div class="section-title">
      <?php if(!empty($title)):?>
      <h2 class="title"><?php echo $title;?></h2>
      <?php endif;?>
      <?php if(!empty($description)):?>
      <div class="description"><?php echo $description;?></div>
      <?php endif;?>
    </div>
    <?php endif;?>
    <?php if(!empty($banners)):?>
    <div id="sabers-carousel" class="swiper-container">
      <div class="swiper-wrapper">
      <?php foreach ($banners as $banner) :?>
        <div class="swiper-slide">
        <?php if($banner['link']) : ?>
          <a href="<?php echo $banner['link']; ?>">
            <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>">
            <?php if(!empty($banner['title'])):?>
            <span class="label"><?php echo $banner['title']; ?></span>
            <?php endif;?>
          </a>
         <?php else : ?>
            <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>">
            <?php if(!empty($banner['title'])):?>
            <span class="label"><?php echo $banner['title']; ?></span>
            <?php endif;?>
        <?php endif; ?>
        </div>
      <?php endforeach;?>
      </div>
      <div class="swiper-button-prev .swiper-button-white"></div>
      <div class="swiper-button-next .swiper-button-white"></div>
    </div>
    <?php endif;?>
  </div>
</section>