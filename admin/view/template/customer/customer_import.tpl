<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
      	<a href="<?php echo $sampleexport; ?>" data-toggle="tooltip" title="<?php echo $sample_export; ?>" class="btn btn-success"><i class="fa fa-file-excel-o"></i></a>
      	<?php if(!isset($sampletabledata) && empty($sampletabledata)):?>
      	<button id="save-export" class="btn btn-primary" data-toggle="tooltip" title="Save"><i class="fa fa-save"></i></button>
	    <?php else:?>
	    <a href="<?php echo $back; ?>" data-toggle="tooltip" title="Go Back" class="btn btn-primary"><i class="fa fa-step-backward"></i> Go Back</a>
	    <?php endif;?>
		</div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
	<?php if ($error_warning) { ?>
	    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
	      <button type="button" class="close" data-dismiss="alert">&times;</button>
	    </div>
	    <?php } ?>
	    <?php if ($error_file) { ?>
	    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_file; ?>
	      <button type="button" class="close" data-dismiss="alert">&times;</button>
	    </div>
	    <?php } ?>
	    <?php if ($success) { ?>
	    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
	      <button type="button" class="close" data-dismiss="alert">&times;</button>
	    </div>
	    <?php } ?>
	<?php if(count($excel_fields_error)>0) :?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i>
			<?php foreach($excel_fields_error as $current_error) :?>
			<p><?php echo $current_error;?></p>";
			<?php endforeach;?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
	    </div>
	<?php endif;?>	 
		<?php if(!isset($sampletabledata) && empty($sampletabledata)):?>
		<form action="<?php echo $action; ?>" id="import-form" method="post" enctype="multipart/form-data" id="form-customer">
          <div class="table-responsive">
            <table class="table table-bordered table-hover">
              <thead>
              	<tr>
					<td class="text-left"><?php echo $entry_import; ?></td>
					<td class="text-left"></td>
				</tr>
			  </thead>
			  </thead>
              <tbody>
              	<tr>
              		<td class="text-left"><?php echo $entry_import; ?></td>
			  		<td class="text-left">
						<input type="file" name="file" class="form-control"/>
						<?php if ($error_file) { ?>
						<span class="text-danger"><?php echo $error_file; ?></span>
						<?php } ?>
						<?php if ($error_fields) { ?>
						<span class="text-danger"><?php echo $error_fields; ?></span>
						<?php } ?>
			  		</td>
              	</tr>
              </tbody>
            </table>
          </div>
        </form>
    <?php else:?>
		<div class="table-responsive">
            <table class="table table-bordered table-hover">
              <thead>
              	<tr>
					<td class="text-left">First Name</td>
					<td class="text-left">Last Name</td>
					<td class="text-left">Email</td>
					<td class="text-left">Telephone</td>
					<td class="text-left">Import Status</td>
				</tr>
			  </thead>
			  </thead>
              <tbody>
              	<?php if(isset($sampletabledata) && !empty($sampletabledata)):?>
              	<?php foreach($sampletabledata as $customerdata) :?>
              	<tr>
              		<td class="text-left"><?php echo $customerdata['firstname'];?></td>
              		<td class="text-left"><?php echo $customerdata['lastname'];?></td>
              		<td class="text-left"><?php echo $customerdata['email'];?></td>
              		<td class="text-left"><?php echo $customerdata['telephone'];?></td>
              		<td class="text-left"><?php 
              		if($customerdata['import_status'] == 1) {
              			echo "<span class=\"text-success\"><i class=\"fa fa-check\"></i></span>";
              		} else {
              			echo "<span class=\"text-danger\"><i class=\"fa fa-exclamation-triangle\"></i> ".$customerdata['import_status']."</span>";
              		}
              		?></td>
              	</tr>
              	<?php endforeach;?>
              	<?php endif;?>
              </tbody>
            </table>
          </div>
    <?php endif;?>
    </div>
<script type="text/javascript"><!--
    $('#save-export').on('click', function(e) {
    	e.preventDefault();
        $('#import-form').submit();
    });
//--></script>
<?php echo $footer; ?>