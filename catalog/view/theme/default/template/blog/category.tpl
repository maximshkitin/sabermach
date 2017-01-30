<?php echo str_replace('</header>', '', $header); ?>

  <div id="header-title">
      <div class="container">
        <div id="pages-nav">
          <ul class="clearfix">
          <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
          <?php } ?>
          </ul>
        </div>
        <section class="main-heading">
          <h1 class="skew-heading">Knowledge Base</h1>
        </section>
      </div>
  </div>
</header>
<div class="knlg" id="content">
  <div class="container">
    <div class="row">
      <aside class="col-md-4" id="aside">
          <?php echo $column_left; ?>
          
        <div class="contact-info">
          <p class="intro">If you cannot find unanswered question on knowledgebase pages, please message our support team using the <!-- <a class="show-form" href="#">contact form</a>  or--> contact:</p>
          <p>
            <strong>
              <a href="mailto:<?php echo $help_email;?>">
                  <i class="fa fa-envelope-o"></i> <?php echo $help_email;?>
              </a>
            </strong>
          </p>
          <p>
            <strong>
              <a href="tel:<?php echo $help_phone;?>">
                <i class="fa fa-phone"></i> <?php echo $help_phone;?>
              </a>
            </strong>
          </p>
        </div>
      </aside>
      <div class="col-md-8" id="right-side">
        <section class="active" id="single-article">
          <h2 class="content-heading"><?php echo $heading_title; ?></h2>
          <?php if(!empty($description)):?>
          <section class="content-section">
            <?php echo $description; ?>
          </section>
          <?php endif;?>
          <?php if(!empty($blog_posts)):?>
          <?php foreach ($blog_posts as $blog_post) { ?>
          <section class="content-section">
            <h3 class="content-subheading">
              <?php echo $blog_post['title']; ?></a>
            </h3>
            <?php echo $blog_post['description']; ?>
          </section>
          <?php } ?>
          <?php else :?>
          <section class="content-section">
            <p><?php echo $text_empty; ?></p>
          </section>
          <?php endif;?>
        </section>
        <?php echo $pagination; ?>
      </div>
    </div>
  </div>
</div>

<div id="modal">
  <div class="loader-icon"></div>
</div>
<?php echo $footer; ?>