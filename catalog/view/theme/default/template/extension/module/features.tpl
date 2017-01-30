<section id="features" class="home-section section-features">
	<div class="saber-image">
		<div class="saber-container">
			<div class="saber-photo"></div>
		</div>
	</div>
	<?php if(!empty($items)):?>
	<div class="features-list">
		<ul>
		<?php foreach ($items as $key => $item):?>
			<li class="feature feature-<?php echo $key + 1;?>">
				<a href="#"  class="feature-point">	
					<svg viewBox="0 0 150 150" class="icon icon-plus">
						<use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_plus"></use>
					</svg>
				</a>
				<div class="feature-info no-photo">
					<h3 class="feature-title">
						<svg viewBox="0 0 150 150" class="icon icon-bullet">
							<use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_bullet"></use>
						</svg><?php echo $item->title;?></h3>
					<p class="feature-description"><?php echo $item->description;?></p>
					<a href="index.html#" class="close-x">
						<svg viewBox="0 0 150 150" class="icon icon-x">
							<use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_x"></use>
						</svg>
					</a>
				</div>
			</li>
		<?php endforeach;?>
		</ul>
	</div>
	<?php endif;?>

	<div class="do-action-text">
		<?php if($heading_title): ?>
		<h2 class="title"><?php echo $heading_title;?></h2>
		<?php endif;?>
		<svg viewBox="0 0 150 150" class="icon icon-shine">
			<use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_shine"></use>
		</svg>
		<?php echo $text_click_for_detail;?>
		<svg viewBox="0 0 150 150" class="icon icon-shine">
			<use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_shine"></use>
		</svg>
	</div>
</section>