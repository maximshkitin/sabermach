<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-review" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><i class="fa fa-comments"></i> <?php echo $heading_title; ?></h1>
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
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-review" class="form-horizontal">
          <input type="hidden" name="customer_id" value="<?php echo $customer;?>">
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-author"><?php echo $entry_author; ?></label>
            <div class="col-sm-10">
              <input type="text" name="author" value="<?php echo $author; ?>" placeholder="<?php echo $entry_author; ?>" id="input-author" class="form-control" />
              <?php if ($error_author) { ?>
              <div class="text-danger"><?php echo $error_author; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-group">Group</label>
            <div class="col-sm-10">
              <input type="text" name="groups" value="<?php echo $groups; ?>" placeholder="Group" id="input-group" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-avatar">Avatar</label>
            <div class="col-sm-3">
               <a href="#" id="thumb-avatar" data-toggle="image" class="img-thumbnail"><img src="<?php echo (!empty($avatar))? $avatar : $placeholder_avatar; ?>" alt="" title="" data-placeholder="<?php echo $placeholder_avatar; ?>" /></a><input type="hidden" name="avatar" value="<?php echo $avatar; ?>" id="input-avatar" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-date-added"><?php echo $entry_date_added; ?></label>
            <div class="col-sm-3">
              <div class="input-group date">
                <input type="text" name="date_added" value="<?php echo $date_added; ?>" placeholder="<?php echo $entry_date_added; ?>" data-date-format="YYYY-MM-DD" id="input-date-added" class="form-control" />
                    <span class="input-group-btn">
                    <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                    </span>
              </div>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-text"><?php echo $entry_text; ?></label>
            <div class="col-sm-10">
              <textarea name="text" cols="60" rows="8" placeholder="<?php echo $entry_text; ?>" id="input-text" class="form-control"><?php echo $text; ?></textarea>
              <?php if ($error_text) { ?>
              <span class="text-danger">
              <?php echo $error_text; ?></span>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-avatar">Attachments</label>
            <div class="col-sm-10">
            <?php $row = 0;?>
              <table id="files-list" class="table table-striped table-hover">
                  <tbody>
            <?php if(!empty($files)):?>
            <?php foreach ($files as $key => $file) :?>
                  <tr id="file-row<?php echo $row; ?>" width="90%">
                      <td class="text-left"><a href="#" id="thumb-file-<?php echo $row; ?>" data-toggle="image" class="img-thumbnail"><img src="<?php echo (!empty($file['thumb']))? $file['thumb'] : $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="files[]" value="<?php echo  $file['image']; ?>" id="input-file-<?php echo $row; ?>" /></td>
                      <td class="text-left"><button type="button" onclick="$('#file-row<?php echo $row; ?>, .tooltip').remove();" data-toggle="tooltip" title="Remove" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                  </tr>
                  <?php $row++;?>
            <?php endforeach;?>
            <?php else:?>
                  <tr id="file-row<?php echo $row; ?>">
                      <td class="text-left"><a href="#" id="thumb-file-<?php echo $row; ?>" data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="files[]" value="" id="input-file-<?php echo $row; ?>" /></td>
                      <td class="text-right"><button type="button" onclick="$('#file-row<?php echo $row; ?>, .tooltip').remove();" data-toggle="tooltip" title="Remove" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                  </tr>
                  <?php $row++;?>
            <?php endif;?>
                </tbody>
                <tfoot>
                  <tr>
                    <td></td>
                    <td class="text-right"><button type="button" onclick="addFile();" data-toggle="tooltip" title="Add File" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                  </tr>
                </tfoot>
              </table>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="status" id="input-status" class="form-control">
                <?php if ($status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
  $('.date').datetimepicker({
    pickTime: false
  });

  $('.time').datetimepicker({
    pickDate: false
  });

  $('.datetime').datetimepicker({
    pickDate: true,
    pickTime: true
  });
  //--></script>
  <script type="text/javascript"><!--
var file_row = <?php echo $row; ?>;

function addFile() {
  html  = '<tr id="file-row' + file_row + '">';
  html += '  <td class="text-left" width="90%"><a href="#" id="thumb-file-' + file_row + '" data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="files[]" value="" id="input-file-' + file_row + '" /></td>';
  html += '  <td class="text-right"><button type="button" onclick="$(\'#file-row' + file_row  + ', .tooltip\').remove();" data-toggle="tooltip" title="Remove" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
  html += '</tr>';
  
  $('#files-list tbody').append(html);
  
  file_row++;
}
//--></script> 
<?php echo $footer; ?>