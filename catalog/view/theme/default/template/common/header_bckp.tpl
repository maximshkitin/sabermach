<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content= "<?php echo $keywords; ?>" />
<?php } ?>
<link rel="stylesheet" href="catalog/view/theme/default/stylesheet/font-awesome.css">
<link rel="stylesheet" href="catalog/view/theme/default/stylesheet/bootstrap.css">

<link href="//cdn.rawgit.com/noelboss/featherlight/1.5.1/release/featherlight.min.css" type="text/css" rel="stylesheet" />

<?php 
$replace = array(
  'product-category-' => 'catalog/view/theme/default/stylesheet/store.css',
  'checkout-' => 'catalog/view/theme/default/stylesheet/store.css'
);
$style = 'catalog/view/theme/default/stylesheet/style.css';
foreach ($replace as $key => $value) {
  if (strpos($class, $key) !== false) {
    $style = $value;
    break;
  }
}
?>
<link rel="stylesheet" href="<?php echo $style;?>">
<script src="catalog/view/theme/default/js/jquery-1.12.0.min.js" type="text/javascript"></script>
<script src="catalog/view/javascript/common.js" type="text/javascript"></script>
<?php 
$replace = array(
  'information-' => 'page',
  'error-' => 'page',
  'product-product-' => 'product',
  'product-category-' => 'store',
  'checkout-' => 'store checkout',
  'blog' => 'knlg'
);
foreach ($replace as $key => $value) {
  if (strpos($class, $key) !== false) {
    $class = $value;
    break;
  }
}
?>
<?php $class = str_replace('common-', '', $class);?>
<?php if($class == 'home'):?>

<?php else:?>
<script src="catalog/view/theme/default/js/jquery.liveFilter.js" type="text/javascript"></script>
<script src="catalog/view/theme/default/js/common.js" type="text/javascript"></script>
<script src="//cdn.rawgit.com/noelboss/featherlight/1.5.1/release/featherlight.min.js" type="text/javascript" charset="utf-8"></script>
<?php endif;?>
<?php foreach ($styles as $style) { ?>
<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<?php foreach ($scripts as $script) { ?>
<script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } ?>
<?php foreach ($analytics as $analytic) { ?>
<?php echo $analytic; ?>
<?php } ?>
</head>
<body class="<?php echo $class; ?>">
<header class="site-header" id="top">
  <div class="fixed-bar">
  <div id="top-line"></div>
  <div class="clearfix" id="header-content">
    <div class="container">
      <div class="soc-networks">
        <?php if(!empty($social)):?>
        <ul>
          <?php foreach ($social as $item) :?>
          <li><a href="<?php echo $item->url;?>" target="_blank"><i class="<?php echo $item->class;?>"></i></a></li>
          <?php endforeach;?>
        </ul>
      <?php endif;?>
      </div>
      <div id="logo">
        <a href="<?php echo $home;?>"></a>
      </div>
        <div id="main-nav">
          <nav>
            <ul>
              <li class="bg-li store dd-menu">
                <a href="http://staging.sabermach.com/store">Store</a>
                                <ul class="clearfix">
                                    <li>
                    <a href="http://staging.sabermach.com/store/sports_series">
                                          Sports<br>
                      <span>Series</span>
                      <i class="fa fa-chevron-right"></i>
                                        </a>
                  </li>
                                    <li>
                    <a href="http://staging.sabermach.com/store/junior_series">
                                          Junior<br>
                      <span>Series</span>
                      <i class="fa fa-chevron-right"></i>
                                        </a>
                  </li>
                  <li class="has-submenu">
                    <a href="http://staging.sabermach.com/store/adept-series">
                                          Master<br>
                      <span>Series</span>
                      <i class="fa fa-chevron-right"></i></a>
                      <ul class="clearfix">
                        <li>
                          <a href="http://staging.sabermach.com/store/expert-series">
                                              Expert<br>
                          <span>Series</span>
                          <i class="fa fa-chevron-right"></i>
                                            </a>
                        </li>
                        <li>
                          <a href="http://staging.sabermach.com/store/expert-1-series">
                                              Expert<br>
                          <span>Flash Series</span>
                          <i class="fa fa-chevron-right"></i>
                                            </a>
                        </li>
                        <li>
                          <a href="http://staging.sabermach.com/store/master-series">
                                              Master<br>
                          <span>Series</span>
                          <i class="fa fa-chevron-right"></i>
                                            </a>
                        </li>
                      </ul>
                  </li>
                </ul>
              </li>
              <li class="bg-li cart">
                <a href="http://staging.sabermach.com/checkout">Cart                                </a>
              </li>
              <li class="dd-menu">
                <span></span>
                <span></span>
                <span></span>
                <ul class="clearfix">
                  <li>
                    <a href="http://staging.sabermach.com/">
                      <i class="fa fa-home"></i>
                      <span>Home</span>
                    </a>
                  </li>
                  <li>
                    <a href="http://staging.sabermach.com/contacts">
                      <i class="fa fa-info-circle"></i>
                      <span>About</span>
                    </a>
                  </li>
                  <li>
                    <a href="http://staging.sabermach.com/contacts#faq">
                      <i class="fa fa-question-circle"></i>
                      <span>FAQ</span>
                    </a>
                  </li>
                                    <li>
                    <a href="http://staging.sabermach.com/login">
                      <i class="fa fa-sign-in"></i>
                      <span>Login</span>
                    </a>
                  </li>
                                    <li>
                    <a href="http://staging.sabermach.com/contacts#contact">
                      <i class="fa fa-envelope"></i>
                      <span>Contact Us</span>
                    </a>
                  </li>
                </ul>
              </li>
            </ul>
          </nav>
        </div>
      </div>
    </div>
  </div>
<?php if($class != 'product'):?>
</header>
<?php endif;?>

