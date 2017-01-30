<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-html" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
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
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-html" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
              <?php if ($error_name) { ?>
              <div class="text-danger"><?php echo $error_name; ?></div>
              <?php } ?>
            </div>
          </div>         
          <div class="tab-pane">
            <ul class="nav nav-tabs" id="language">
              <?php foreach ($languages as $language) { ?>
              <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
              <?php } ?>
            </ul>
            <div class="tab-content">
              <?php $row = 0; ?>
              <?php foreach ($languages as $language) { ?>
              <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-title<?php echo $language['language_id']; ?>"><?php echo $entry_title; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="module_description[<?php echo $language['language_id']; ?>][title]" placeholder="<?php echo $entry_title; ?>" id="input-heading<?php echo $language['language_id']; ?>" value="<?php echo isset($module_description[$language['language_id']]['title']) ? $module_description[$language['language_id']]['title'] : ''; ?>" class="form-control" />
                  </div>
                </div>
                <table id="items<?php echo $language['language_id']; ?>" class="table table-striped table-bordered table-hover">
                  <thead>
                    <tr>
                      <td class="text-left"><?php echo $entry_title; ?></td>
                      <td class="text-left"><?php echo $entry_description; ?></td>
                      <td></td>
                    </tr>
                  </thead>
                  <tbody>
                    <?php if (isset($items[$language['language_id']])) { ?>
                    <?php foreach ($items[$language['language_id']] as $item) { ?>
                    <tr id="row<?php echo $row; ?>">
                      <td class="text-left" style="width: 30%;"><input type="text" name="items[<?php echo $language['language_id']; ?>][<?php echo $row; ?>][title]" value="<?php echo $item['title']; ?>" placeholder="<?php echo $entry_title; ?>" class="form-control" />
                        <?php if (isset($error_item[$language['language_id']][$row])) { ?>
                        <div class="text-danger"><?php echo $error_item[$language['language_id']][$row]; ?></div>
                        <?php } ?></td>
                      <td class="text-left" style="width: 60%;"><textarea name="items[<?php echo $language['language_id']; ?>][<?php echo $row; ?>][description]" placeholder="<?php echo $entry_description; ?>" class="form-control"><?php echo $item['description']; ?></textarea></td>
                      <td class="text-left"><button type="button" onclick="$('#row<?php echo $row; ?>, .tooltip').remove();" data-toggle="tooltip" title="<?php echo $text_del_row; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                    </tr>
                    <?php $row++; ?>
                    <?php } ?>
                    <?php } ?>
                  </tbody>
                  <tfoot>
                    <tr>
                      <td colspan="2"></td>
                      <td class="text-left"><button type="button" onclick="addRow('<?php echo $language['language_id']; ?>');" data-toggle="tooltip" title="<?php echo $text_add_row; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                    </tr>
                  </tfoot>
                </table>

              </div>
              <?php } ?>
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
  <script type="text/javascript"><!--
var row = <?php echo $row; ?>;

function addRow(language_id) {
  html  = '<tr id="row' + row + '">';
    html += '  <td class="text-left" style="width: 30%;"><input type="text" name="items[' + language_id + '][' + row + '][title]" value="" placeholder="<?php echo $entry_title; ?>" class="form-control" /></td>';  
  html += '  <td class="text-left" style="width: 60%;"><textarea name="items[' + language_id + '][' + row + '][description]" placeholder="<?php echo $entry_description; ?>" class="form-control"></textarea></td>';  
  html += '  <td class="text-left"><button type="button" onclick="$(\'#row' + row  + ', .tooltip\').remove();" data-toggle="tooltip" title="<?php echo $text_del_row; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
  html += '</tr>';
  
  $('#items' + language_id + ' tbody').append(html);
  
  row++;
}
//--></script>
  <script type="text/javascript"><!--
$('#language a:first').tab('show');
//--></script></div>
<?php echo $footer; ?>