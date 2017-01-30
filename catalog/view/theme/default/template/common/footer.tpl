<footer id="footer">
  <div class="container">
    <div class="left-side">
      <span class="copyright">
        &copy; <?php echo date('Y');?> <span><?php echo $name;?></span>
      </span>
      <div class="footer-nav">
        <ul class="clearfix">
          <li><a href="<?php echo $policies;?>"><?php echo $text_policies;?></a></li>
          <li><a href="<?php echo $contact; ?>#tandc"><?php echo $text_contact_us;?></a></li>
          <li><a href="<?php echo $contact; ?>#faq"><?php echo $text_terms;?></a></li>
          <li><a href="<?php echo $contact; ?>#contact"><?php echo $text_faq;?></a></li>
          <li><a href="<?php echo $knb;?>"><?php echo $text_help_center;?></a></li>
        </ul>
      </div>
    </div>
    <div class="right-side">
      <div class="soc-networks">
        <?php if(!empty($social)):?>
        <ul class="clearfix">
          <?php foreach ($social as $item) :?>
          <li><a href="<?php echo $item->url;?>" target="_blank"><i class="<?php echo $item->class;?>"></i></a></li>
          <?php endforeach;?>
        </ul>
      <?php endif;?>
      </div>
      <div class="to-top">
        <i class="fa fa-angle-up"></i><br>
        <?php echo $back_to_top;?>
      </div>
      <p class="made-by">Powered by TRV Creative</p>
    </div>
  </div>
</footer>
</body></html>