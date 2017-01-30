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
          <h1 class="skew-heading">Discussion Board</h1>
        </section>
      </div>
  </div>
</header>
<div id="content">
  <div class="container">
    <div class="d-board" id="right-side">
      <section class="active" id="single-article">
          <section class="comments">
              <h2 class="content-subheading">
                  <i class="fa fa-comments"></i>
                  Discussion Board <?php echo (!empty($count)) ? '(' . $count . ')' : '';?>
              </h2>
              <?php if(!empty($reviews)):?>
              <?php foreach ($reviews as $review) :?>
              <div class="comment-box clearfix">
                  <div class="user-info">
                      <img src="<?php echo $review['avatar'];?>" alt="<?php echo htmlspecialchars($review['author']);?>">
                      <p class="name"><?php echo $review['author'];?></p>
                      <?php if(!empty($review['group'])):?>
                      <p class="status">
                          <span></span>
                          <?php echo $review['group'];?>
                      </p>
                      <?php endif;?>
                  </div>
                  <div class="comment-text">
                      <p class="message"><?php echo $review['text'];?></p>
                      <?php if(!empty($review['files'])):?>
                      <?php foreach ($review['files'] as $file) :?>
                      <a data-featherlight="<?php echo $file['image'];?>" href="#">
                          <img src="<?php echo $file['thumb'];?>" alt="">
                      </a>
                      <?php endforeach;?>
                      <?php endif;?>
                      <p class="date"><?php echo $review['date_added'];?></p>
                  </div>
              </div>
              <?php endforeach;?>
              <?php endif;?>
              <?php echo $pagination;?>
          </section>
          <section class="reply">
              <hr>
              <h2 class="content-subheading">
                  <i class="fa fa-comments"></i> Reply
              </h2>
              <div class="comment-box clearfix">
                  <div class="user-info">
                      <img src="<?php echo $avatar;?>" alt="<?php echo htmlspecialchars($customer_name);?>">
                      <p class="name">
                          <?php echo $customer_name;?>
                      </p>
                  </div>
                  <div class="comment-text">
                      <form action="" id="reply-comment">
                          <textarea name="text" id="comment-text" rows="6" required></textarea>
                          <hr class="dark">
                          <div class="submit-line clearfix">
                              <div class="pinned-images">
                                  <div class="item add-img review-add">
                                      <div>
                                          <i class="fa fa-picture-o"></i>
                                      </div>
                                      add image
                                  </div>
                              </div>
                              <div class="submit-wrap">
                                  <div>
                                      <i class="fa fa-paper-plane"></i>
                                      <input class="submit-button" type="submit" value="Submit">
                                  </div>
                              </div>
                          </div>
                      </form>
                  </div>
              </div>
          </section>
      </section>
      <section class="" id="contact-form">
          <h2 class="content-heading">Contact support</h2>
          <p>If you cannot find answer to your question, please use this form to send a message to us and we will get back to you shortly.</p>
          <form class="novalidate" action="#" id="message-form">
            <table>
              <tbody>
                <tr>
                  <td>Full Name</td>
                  <td class="inputs-2">
                    <div class="input-field">
                      <input class="dark-input" type="text" id="input-user-name" name="firstname" value="<?php echo $firstname;?>" placeholder="First Name..." required>
                    </div>
                    <div class="input-field">
                      <input class="dark-input" type="text" id="input-user-surname" name="lastname" value="<?php echo $lastname;?>" placeholder="Last Name..." required>
                    </div>
                  </td>
                </tr>
                <tr>
                  <td>Phone</td>
                  <td>
                    <div class="input-field">
                      <input class="dark-input check-numeric" type="text" name="telephone" value="<?php echo $telephone;?>" required>
                    </div>
                  </td>
                </tr>
                <tr>
                  <td>Email</td>
                  <td>
                    <div class="input-field">
                      <input class="dark-input" type="email" name="email" value="<?php echo $email;?>" required>
                    </div>
                  </td>
                </tr>
                <?php if(!empty($subjects)):?>
                <tr>
                  <td>Select subject</td>
                  <td>
                    <div class="input-field">
                      <select class="dark-input" name="subject">
                      <?php foreach ($subjects as $key => $subject) :?>
                        <option value="<?php echo $subject;?>"<?php ($key == 0) ? ' selected="selected"' : '';?>><?php echo $subject;?></option>
                      <?php endforeach;?>
                      </select>
                    </div>
                  </td>
                </tr>
                <?php endif;?>
                <?php if(!empty($products)):?>
                <tr>
                  <td>Related product</td>
                  <td class="radio-buttons">
                    <?php foreach ($products as $key => $product) :?>
                    <input name="series" type="radio" name="product" id="product-radio-<?php echo $key;?>" value="<?php echo $product;?>"<?php echo ($key == 0) ? ' checked' : '';?>>
                    <label for="product-radio-<?php echo $key;?>">
                      <span></span>
                      <?php echo str_replace('1', ' <i class="fa fa-flash"></i>', $product);?>
                    </label>
                    <?php endforeach;?>
                  </td>
                </tr>
                <?php endif;?>
                <tr>
                  <td>Message</td>
                  <td>
                    <div class="input-field">
                      <textarea class="dark-input" name="message" id="" rows="5" required></textarea>
                    </div>
                  </td>
                </tr>
                <tr>
                  <td>
                    Attachment<br>
                    <span>(jpg, png, gif)</span>
                  </td>
                  <td>
                    <div class="pinned-images">
                      <input type="hidden" name="attachment" id="contact-attached-image" value="" class="get-photo">
                      <div class="item add-img">
                        <div>
                          <i class="fa fa-picture-o"></i>
                        </div>
                        add image
                      </div>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
            <hr class="dark">
            <div class="checkbox">
              <input type="checkbox" id="checkbox-confirm" name="searched" value="1">
              <label for="checkbox-confirm">
                I have searched <a href="<?php echo $knb;?>">knowledge articles</a> and could not find the answer to my question
              </label>
            </div>
            <div class="submit-wrap clearfix">
              <div>
                <i class="fa fa-paper-plane"></i>
                <input class="submit-button" type="submit" value="Submit">
              </div>
            </div>
            <div class="warning-box">
              <p><i class="fa fa-exclamation-triangle"></i> All fields are required! Please fill out them.</p>
            </div>
          </form>
        </section>
    </div>
  </div>
</div>
<?php echo $form_message;?>
<div id="modal">
  <div class="loader-icon"></div>
</div>

<script src="catalog/view/theme/default/js/validation/jquery.validate.min.js" type="text/javascript"></script>
<script type="text/javascript"><!--
$('.add-img.review-add').click(function(e){
  e.preventDefault();
  var node = this;

  $('#form-upload').remove();

  $('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

  $('#form-upload input[name=\'file\']').trigger('click');

  if (typeof timer != 'undefined') {
      clearInterval(timer);
  }

  timer = setInterval(function() {
    if ($('#form-upload input[name=\'file\']').val() != '') {
      clearInterval(timer);

      $.ajax({
        url: 'index.php?route=tool/upload/contact',
        type: 'post',
        dataType: 'json',
        data: new FormData($('#form-upload')[0]),
        cache: false,
        contentType: false,
        processData: false,
        beforeSend: function() {
          //$(node).button('loading');
        },
        complete: function() {
          //$(node).button('reset');
        },
        success: function(json) {
          $(node).parent().find('.text-danger').remove();

          if (json['error']) {
            $(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
          }

          if (json['success']) {
            $('#reply-comment .pinned-images').prepend('<div class="item"><div><input type="hidden" name="files[]" value="' + json['attachment'] + '"/><img src="' + json['image'] + '" alt=""></div><a href="#" class="remove-mg-input"><i class="fa fa-close"></i> remove</a></div>');
          }
        },
        error: function(xhr, ajaxOptions, thrownError) {
          alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
      });
    }
  }, 500);
});
$(document).on('click', '.remove-mg-input', function(e){
    e.preventDefault();
    $(this).parent().remove();
});
$('.add-img:not(.review-add)').click(function(e){
  e.preventDefault();
  var node = this;

  $('#form-upload').remove();

  $('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

  $('#form-upload input[name=\'file\']').trigger('click');

  if (typeof timer != 'undefined') {
      clearInterval(timer);
  }

  timer = setInterval(function() {
    if ($('#form-upload input[name=\'file\']').val() != '') {
      clearInterval(timer);

      $.ajax({
        url: 'index.php?route=tool/upload/contact',
        type: 'post',
        dataType: 'json',
        data: new FormData($('#form-upload')[0]),
        cache: false,
        contentType: false,
        processData: false,
        beforeSend: function() {
          //$(node).button('loading');
        },
        complete: function() {
          //$(node).button('reset');
        },
        success: function(json) {
          $(node).parent().find('.text-danger').remove();

          if (json['error']) {
            $(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
            $(node).find('div').html('<i class="fa fa-picture-o"></i>');
          }

          if (json['success']) {
            $("#contact-attached-image").val(json['attachment']);
            $(node).find('div').html('<img src="' + json['image'] + '">');
          }
        },
        error: function(xhr, ajaxOptions, thrownError) {
          alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
      });
    }
  }, 500);
});
$("#message-form").on("submit", function(e) {
  e.preventDefault();
  var form = $(this);
  form.validate();
  if(!form.valid()) {
    $('body').animate({ scrollTop: form.offset().top - 175 }, 500);
  } else {
    $.ajax({
      url: '<?php echo $action;?>',
      type: 'post',
      data: form.serialize(),
      dataType: 'json',
      success: function(json) {
        if(!json.error) {
          location.reload();
        }
      }
    });
  }
  return false;
});
$("#message-form").validate({
  rules: {
    "firstname": {
      required: true
    },
    "lastname": {
      required: true
    },
    "telephone": {
      required: true
    },
    "email": {
      required: true,
      email: true
    },
    "message": {
      required: true
    },
    <?php if(!empty($subjects)):?>
    "subject": {
      required: true
    },
    <?php endif;?>
    <?php if(!empty($products)):?>
    "product": {
      required: true
    },
    <?php endif;?>
    "searched": {
      required: true
    }
  },
  highlight: function(element) {
    $(element).addClass("has-error");
  },
  unhighlight: function(element) {
    $(element).removeClass("has-error");
  },
  errorElement: "div",
  errorClass: "error-block",
  errorPlacement: function(error, element) {}
});
$("#reply-comment").on("submit", function(e) {
  e.preventDefault();
  var form = $(this);
  form.validate();
  if(!form.valid()) {
    $('body').animate({ scrollTop: form.offset().top - 175 }, 500);
  } else {
    $.ajax({
      url: '<?php echo $action_reply;?>',
      type: 'post',
      data: form.serialize(),
      dataType: 'json',
      success: function(json) {
        if(!json.error) {
          location.reload();
        }
      }
    });
  }
  return false;
});
$("#reply-comment").validate({
  rules: {
    "text": {
      required: true
    }
  },
  highlight: function(element) {
    $(element).addClass("has-error");
  },
  unhighlight: function(element) {
    $(element).removeClass("has-error");
  },
  errorElement: "div",
  errorClass: "error-block",
  errorPlacement: function(error, element) {}
});
//--></script>
<?php echo $footer; ?>