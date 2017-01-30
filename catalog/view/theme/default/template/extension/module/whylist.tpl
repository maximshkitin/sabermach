<section id="why" class="home-section section-why">
	<div class="why-intro">
		<?php if($heading_title): ?>
		<h2 class="title"><?php echo $heading_title;?></h2>
		<?php endif;?>
		<?php if($description) {
			echo $description;
		} ?>
	</div>
	<?php if(!empty($items)):?>
	<div class="why-list">
		<ul>
		<?php foreach ($items as $key => $item):?>
			<li id="item-<?php echo $key + 1;?>"<?php echo ($key == 0) ? ' class="active"' : '';?>>
				<span class="why-title">
					<svg viewBox="0 0 150 150" class="icon icon-bullet">
						<use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_bullet"></use>
					</svg><?php echo $item->title;?></span>
				<p class="why-description"><?php echo $item->description;?></p>
			</li>
		<?php endforeach;?>
		</ul>
	</div>
	<?php endif;?>
	<div class="do-action-text">
		<svg viewBox="0 0 150 150" class="icon icon-shine">
			<use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_shine"></use>
		</svg>
		<?php echo $text_turn_around;?>
		<svg viewBox="0 0 150 150" class="icon icon-shine">
			<use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_shine"></use>
		</svg>
	</div>
</section>