<?php echo $header; ?>
	<div class="product" id="header-title">
		<div class="container">
			<div id="pages-nav">
				<ul class="clearfix">
					<?php foreach ($breadcrumbs as $breadcrumb) : ?>
					<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
					<?php endforeach; ?>
				</ul>
			</div>
			<div class="row" id="header-product">
				<div class="col-md-5 col-sm-12">
					<div class="wrapper">
						<section id="product-intro">
							<h1><?php echo str_replace('1', ' <i class="fa fa-flash"></i>', $heading_title);?></h1>
							
							<?php if(!empty($images)) :?>
								<?php $slider_counter = 0; foreach ($images as $key => $image_group) : ?>
									<?php $slider_counter++; ?>
									<div class="bxslider_wrap_<?php echo $key; ?>" <?php if($slider_counter > 1) echo 'style="display: none"'; ?>>
										<ul class="bxslider main-sl">
											<?php foreach ($image_group as $slider_image) : ?>
												<li>
													<a data-featherlight="<?php echo $slider_image['popup'];?>" href="#">
														<img src="<?php echo $slider_image['thumb'];?>" alt="<?php echo htmlspecialchars($heading_title);?>">
													</a>
												</li>
											<?php endforeach; ?>
										</ul>
									</div>
								<?php endforeach;?>
							<?php elseif(!empty($image)): ?>
								<ul>
									<li>
										<a data-featherlight="<?php echo $image;?>" href="#">
											<img src="<?php echo $image;?>" alt="<?php echo htmlspecialchars($heading_title);?>">
										</a>
									</li>
								</ul>
							<?php endif;?>
						</section>
					</div>
				</div>
				<div class="col-md-7 col-sm-12">
					<div class="descr-box right-line first">
						<div class="title">
							<div>Overview</div>
							<b></b>
						</div>
						<?php echo $description;?>
					</div>
					<?php if(!empty($hilts)) :?>
					<div class="descr-box right-line last">
						<div class="title">
							<div>Option <span>(<?php echo count($hilts);?> hilt models available)</span></div>
							<b></b>
						</div>
						<div class="options-list">
							<ul class="clearfix">
							<?php foreach ($hilts as $hilt) :?>
								<li data-hilt_options_id="bxslider_wrap_<?php echo $hilt['option_value_id']?>">
									<div class="tooltip">Click to View</div>
									<div class="img">
										<div class="cell">
											<div class="img-blur">
												<img src="<?php echo $hilt['image'];?>" alt="<?php echo htmlspecialchars($hilt['name']);?>">
											</div>
										</div>
									</div>
									<span><?php echo $hilt['name'];?></span>
								</li>
							<?php endforeach;?>
							</ul>
						</div>
					</div>
					<?php endif;?>
				</div>
			</div>    
		</div>
	</div>
</header>
<div class="product" id="content">
	<div id="fixed-toggle">
		<div class="product-nav">
			<div class="container">
				<div class="left-side">
					<ul class="clearfix">
					<?php $btotal = count($breadcrumbs) -1;?>
					<?php foreach ($breadcrumbs as $key => $breadcrumb) : ?>
					<?php if($key > 0 && $key != $btotal):?>
						<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
					<?php elseif($key == $btotal):?>
						<li><a href="<?php echo $breadcrumb['href']; ?>"><?php $t = explode(' ', $breadcrumb['text']); echo reset($t); ?></a></li>
					<?php endif;?>
					<?php endforeach; ?>
					</ul>
				</div>
				<div class="right-side">
					<?php if(!empty($menu_products)):?>
					<ul class="clearfix">
					<?php foreach ($menu_products as $item) :?>
						<li<?php echo ($item['product_id'] == $product_id) ? ' class="active"' : ''?>>
							<a href="<?php echo $item['href'];?>">
								<?php echo str_replace('1', ' <i class="fa fa-flash"></i>', $item['name']);?>
							</a>
						</li>
					<?php endforeach;?>
					</ul>
					<?php endif;?>
				</div>
			</div>
		</div>
		<?php if(isset($category) && !empty($category)):?>
		<div class="buy-row">
			<div class="container">
				<div class="clearfix">
					<p>SCROLL FOR DETAILS <a href="<?php echo $category->url.'#product-'.$product_id;?>">OR</a> CLICK BUTTON TO SELECT PREFERENCES (HILT & COLOR)</p>
					<a class="polygon-button yellow" href="<?php echo $category->url.'#product-'.$product_id;?>">
					<?php if ($price): ?>
					<?php if (!$special) : ?>
						<span class="default-price hilt-price active"><?php echo $price; ?></span>
						<span class="kyrotek-price hilt-price">777$</span>
					<?php else : ?>
						<span><?php echo $special; ?></span>
					<?php endif;?>
					<?php endif;?>
						Buy Now
					</a>
					</div>
				</div>
			</div>
		</div>
		<?php endif;?>
		<?php if(!empty($features_items)):?>
		<section class="unique-features">
			<div class="container">
				<div class="heading">
					<h2 class="chrome-heading">
						Unique Features
					</h2>
					<?php if(!empty($features_subheading)):?>
					<p class="subheading-stars">
						<?php echo $features_subheading;?>
					</p>
					<?php endif;?>
				</div>
				<div class="list-features">
					<div class="separator dark"></div>
					<ul class="clearfix">
						<?php foreach ($features_items as $item) :?>
						<li>
							<secion>
								<?php if(!empty($item->image)):?>
								<img src="<?php echo $item->image;?>" alt="<?php echo htmlspecialchars($item->title);?>">
								<?php endif;?>
								<?php if(!empty($item->title)):?>
								<h3>
									<?php echo $item->title;?>
									<b></b>
								</h3>
								<?php endif;?>
								<?php if(!empty($item->description)):?>
								<p><?php echo $item->description;?></p>
								<?php endif;?>
							</secion>
						</li>
						<?php endforeach;?>
					</ul>
				</div>
			</div>
		</section>
		<?php endif;?>
		<section class="options">
			<div class="container">
				<div class="row row-rel">
					<div class="separator yellow"></div>
					<div class="col-md-6">
						<div class="heading">
							<h2 class="chrome-heading">
								Options...
							</h2>
							<p class="subheading-stars">
								Technical Specification
							</p>
							<?php if(!empty($technical_specification_description)) :?>
							<p class="descr">
								<?php echo $technical_specification_description;?>
							</p>
							<?php endif;?>
							<?php if(!empty($downloads)):?>
							<hr class="dark">
							<?php foreach ($downloads as $item) :?>
							<!-- <div class="download-box clearfix">
								<a href="<?php echo $item->url;?>">
									<i class="fa fa-file-pdf-o"></i>
									<p>
										Download the <?php echo str_replace($heading_title, '<strong>' . $heading_title . '</strong>', $item->name);?>
									</p>
								</a>
							</div> -->
						<?php if(!empty($colors)) : ?>
							<ul class="colors">
								<?php foreach($colors as $color) : ?>
									<li>
										<div class="item">
											<img src="<?php echo $color['image']; ?>" alt="<?php echo $color['name']; ?>">
											<p><?php echo $color['name']; ?></p>
										</div>
									</li>
								<?php endforeach; ?>
							</ul>
						<?php endif; ?>
							<?php endforeach;?>
							<?php endif;?>
						</div>
					</div>
					<div class="col-md-6">
						<div class="table-wrapper">
							<?php if(!empty($tech_data)):?>
							<table>
								<tbody>
								<?php foreach ($tech_data as $item) :?>
									<tr>
										<td><?php echo $item['name'];?></td>
										<td>
										<?php 
											$text = html_entity_decode($item['text'], ENT_QUOTES, 'UTF-8');
											$text = explode("\n", $text);
											$total = count($text);
										?>
										<?php if($total == 1) :?>
											<?php echo reset($text);?>
										<?php else :?>
											<ul>
											<?php foreach ($text as $value) :?>
												<li><?php echo $value;?></li>
											<?php endforeach;?>
											</ul>
										<?php endif;?>
										</td>
									</tr>
								<?php endforeach;?>
								</tbody>
							</table>
							<?php endif;?>
						</div>
					</div>
				</div>
			</div>
		</section>
		<?php if(!empty($included_image) || !empty($included_description) || !empty($included_items)):?>
		<section class="include">
			<div class="container">
				<div class="col-md-4">
					<?php if($included_image):?>
					<img src="<?php echo $included_image;?>" alt="What's included...">
					<?php endif;?>
				</div>
				<div class="col-md-8">
					<h2 class="chrome-heading">
						What's included...
					</h2>
					<?php if(!empty($included_description)):?>
					<?php echo $included_description;?>
					<hr class="dark">
					<?php endif;?>
					<?php if(!empty($included_items)):?>
					<ul>
						<?php foreach ($included_items as $item) :?>
						<li><?php echo $item;?></li>
						<?php endforeach;?>
					</ul>
					<?php endif;?>
				</div>
			</div>
		</section>
		<?php endif;?>
		<div class="click-slide">
			<div class="container">
				<p>
					<i class="fa fa-caret-square-o-right"></i>
					BUY <?php echo mb_strtoupper($heading_title);?> NOW! CLICK TO SET PREFERENCES
				</p>
				<?php if(isset($category) && !empty($category)):?>
				<a href="<?php echo $category->url.'#product-'.$product_id;?>" class="polygon-button">
					<i class="fa fa-cart-plus"></i>
					Buy Now
				</a>
				<?php endif;?>
			</div>
		</div>
	</div>
	<div id="modal">
		<div class="loader-icon"></div>
	</div>
	<div id="hilts-slider">
		<div class="wrapper">
			<div class="wrapper2">
				<div class="close-hilt-pop">
					<span>X</span>
				</div>
				<div class="sliders">
					<ul class="bxslider">
						<li>
							<img src="http://staging.sabermach.com/image/cache/catalog/products/product-2-420x364.png" alt="">
						</li>
						<li>
							<img src="http://staging.sabermach.com/image/cache/catalog/products/product-2-420x364.png" alt="">
						</li>
					</ul>
					<ul class="bxslider">
						<li>
							<img src="http://staging.sabermach.com/image/cache/catalog/products/product-2-420x364.png" alt="">
						</li>
						<li>
							<img src="http://staging.sabermach.com/image/cache/catalog/products/product-2-420x364.png" alt="">
						</li>
					</ul>
					<ul class="bxslider">
						<li>
							<img src="http://staging.sabermach.com/image/cache/catalog/products/product-2-420x364.png" alt="">
						</li>
						<li>
							<img src="http://staging.sabermach.com/image/cache/catalog/products/product-2-420x364.png" alt="">
						</li>
					</ul>
				</div>
				
			</div>
		</div>
	</div>
<?php if(!empty($images)):?>
<script>
	$(document).ready(function(){
		$('.bxslider').bxSlider({
			mode: 'fade',
	        pager: true,
	        nextText:'<i class="fa fa-angle-right"></i>',
	        prevText:'<i class="fa fa-angle-left"></i>'
		});
	});
</script>
<?php endif;?>
<?php echo $footer; ?>