<?php foreach ($blog_blocks as $blog_block) { ?>

<?php if ($blog_block == 'search') { ?>

<div id="blog-search" class="input-field livefilter">
  <i class="fa fa-search"></i>
  <input class="dark-input" id="livefilter-input" type="text" name="filter_title" value="<?php echo $filter_title; ?>"
  placeholder="Search topic here...">
</div>
<hr class="dark">

<?php } elseif ($blog_block == 'categories') { ?>

<section id="topics">
  <div class="clearfix">
    <h2>All topics</h2>
    <a class="oval-btn expand-all" href="">
      expand all
      <i class="fa fa-plus-circle"></i>
    </a>
  </div>
  <div class="list-categories">
    <ul class="categories" id="livefilter-list">
    <?php foreach ($categories as $category) { ?>
    <li>
        <i class="fa fa-caret-right"></i>
        <span><?php echo $category['name']; ?></span>
        <?php if(!empty($category['posts'])):?>
        <ul class="submenu">
        <?php foreach ($category['posts'] as $post) :?>
          <li>
            <a href="<?php echo $post['href'];?>"><?php echo $post['title'];?></a>
          </li>
        <?php endforeach;?>
        </ul>
        <?php endif;?>
      </li>
      <li>
    <?php } ?>
    </ul>
  </div>
</section>
<hr class="dark"> 

<?php } elseif ($blog_block == 'recent_posts') { ?>

<?php if(!empty($recent_posts)):?>
<div id="popular-topics">
  <div class="title">
    Popular Topics
  </div>
  <ul>
    <?php foreach ($recent_posts as $recent_post) { ?>
    <li class="clearfix">
      <a href="<?php echo $recent_post['href']; ?>">
        <i class="fa fa-bolt"></i> <span><?php echo $recent_post['title']; ?></span>
      </a>
    </li>
    <?php } ?>
  </ul>
</div>
<hr class="dark">
<?php endif;?>

<?php } ?>
<?php } ?>
<script type="text/javascript"><!--
$(document).ready(function() {
  /* Search */
  $('#blog-search input[name=\'filter_title\']').parent().find('button').on('click', function() {
    url = $('base').attr('href') + 'index.php?route=blog/category';

    var filter_title = $('input[name=\'filter_title\']').val();

    if (filter_title) {
      url += '&filter_title=' + encodeURIComponent(filter_title);
    }

    location = url;
  });

  $('#blog-search input[name=\'filter_title\']').on('keydown', function(e) {
    if (e.keyCode == 13) {
      $('input[name=\'filter_title\']').parent().find('button').trigger('click');
    }
  });
  });
  //--></script>