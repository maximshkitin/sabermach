<?php echo $header; ?>
  <div class="user-page edit-fields" id="content">
    <div class="container">
      <div class="row">
        <aside class="col-md-4" id="aside">
          <div id="avatar">
            <img src="<?php echo $avatar;?>" alt="<?php echo htmlspecialchars($firstname . ' ' .$lastname);?>">
          </div>
          <h2>My Account</h2>
          <ul>
            <li><a href="<?php echo $dashboard;?>"><i class="fa fa-tachometer"></i>  Dashboard</a></li>
            <li><a href="<?php echo $order; ?>"><i class="fa fa-shopping-cart"></i> Orders</a></li>
            <li><a href="<?php echo $edit; ?>"><i class="fa fa-user"></i> Account Details</a></li>
            <!-- <li><a href="<?php echo $knb; ?>"><i class="fa fa-archive"></i> Knowledge Base</a></li> -->
            <li><a href="<?php echo $mb; ?>"><i class="fa fa-group"></i> Support Message board</a></li>
          </ul>
<!--           <div class="note">
            <i class="fa fa-info-circle"></i>
            Visit <a href="<?php echo $knb;?>"><strong>knowlegdebase</strong></a> or <a href="<?php echo $mb;?>"><strong>message board</strong></a> for support
          </div> -->
        </aside>
        <section class="col-md-8" id="right-side">
          <div class="page-nav">
            <ul class="clearfix">
              <?php foreach ($breadcrumbs as $breadcrumb) : ?>
              <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
              <?php endforeach; ?>
            </ul>
          </div>
          <hr class="dark">
          <h1 class="content-heading">
            <i class="fa fa-user"></i>
            Account Details
          </h1>
          <?php if ($success) : ?>
          <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
          <?php endif; ?>
          <?php if ($error_warning) : ?>
          <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
          <?php endif; ?>
          <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
            <div class="content-subheading">
              Edit Contact Details
            </div>
            <hr class="dark">
            <div class="table-wrapper visible">
              <table>
                <tbody>
                  <tr>
                    <td>Full Name</td>
                    <td class="inputs-2">
                      <div class="input-field">
                        <input class="dark-input" id="input-user-name" type="text" placeholder="First Name ..." name="firstname" value="<?php echo $firstname; ?>" required>
                        <?php if ($error_firstname) { ?>
                        <div class="text-danger"><?php echo $error_firstname; ?></div>
                        <?php } ?>
                      </div>
                      <div class="input-field">
                        <input class="dark-input" id="input-user-surname" name="lastname" value="<?php echo $lastname; ?>" type="text" placeholder="Last Name ..." required>
                        <?php if ($error_lastname) { ?>
                        <div class="text-danger"><?php echo $error_lastname; ?></div>
                        <?php } ?>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <td>Email</td>
                    <td><div class="input-field">
                        <input class="dark-input" type="email" name="email" value="<?php echo $email; ?>" required>
                        <?php if ($error_email) { ?>
                        <div class="text-danger"><?php echo $error_email; ?></div>
                        <?php } ?>
                      </div></td>
                  </tr>
                  <tr>
                    <td>Phone</td>
                    <td><div class="input-field">
                        <input class="dark-input" type="text" name="telephone" value="<?php echo $telephone; ?>" required>
                        <?php if ($error_telephone) { ?>
                        <div class="text-danger"><?php echo $error_telephone; ?></div>
                        <?php } ?>
                      </div></td>
                  </tr>
                </tbody>
              </table>
            </div>
            <div class="content-subheading" style="margin-top: 60px;">
              Change Password
            </div>
            <hr class="dark">
            <p><?php echo $text_password; ?></p>
            <div class="table-wrapper pass visible">
              <table>
                <tbody>
                  <tr>
                    <td>New Password</td>
                    <td><div class="input-field">
                        <input class="dark-input" type="password"  name="password" value="<?php echo $password; ?>">
                        <?php if ($error_password) { ?>
                        <div class="text-danger"><?php echo $error_password; ?></div>
                        <?php } ?>
                      </div></td>
                  </tr>
                  <tr>
                    <td>Confirm Password</td>
                    <td><div class="input-field">
                        <input class="dark-input" type="password"  name="confirm" value="<?php echo $confirm; ?>">
                        <?php if ($error_confirm) { ?>
                        <div class="text-danger"><?php echo $error_confirm; ?></div>
                        <?php } ?>
                      </div></td>
                  </tr>
                </tbody>
              </table>
            </div>
            <hr class="dark">
            <div class="buttons">
              <a href="<?php echo $back;?>" class="polygon-button o">
                Cancel
              </a>
              <div class="submit-wrap">
                <i class="fa fa-save"></i>
                <input type="submit" class="submit-button" value="Save">
              </div>
            </div>
          </form>
        </section>
      </div>
    </div>
  </div>
  <div id="modal">
    <div class="loader-icon"></div>
  </div>

<?php echo $footer; ?>
