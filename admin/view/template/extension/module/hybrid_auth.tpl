<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-latest" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-latest" class="form-horizontal">

          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="hybrid_auth_status" id="input-status" class="form-control">
                <?php if ($hybrid_auth_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_debug; ?></label>
            <div class="col-sm-10">
              <select name="hybrid_auth_debug" id="input-status" class="form-control">
                <?php if ($hybrid_auth_debug) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>

          <div class="form-group">
            <div class="col-sm-12">
      <table id="module" class="table table-striped table-bordered table-hover">
        <thead>
          <tr>
            <td class="left"><?php echo $entry_provider; ?></td>
            <td class="left"><?php echo $entry_status; ?></td>
            <td class="left"><?php echo $entry_key; ?></td>
            <td class="left"><?php echo $entry_secret; ?></td>
            <td class="left"><?php echo $entry_scope; ?></td>
            <td class="right"><?php echo $entry_sort_order; ?></td>
            <td></td>
          </tr>
        </thead>
        <?php $row = 0; ?>
        <?php foreach ($hybrid_auth_items as $hybrid_auth) { ?>
        <tbody id="row<?php echo $row; ?>">
          <tr>
            <td class="left">
              <select name="hybrid_auth[<?php echo $row; ?>][provider]" class="form-control">
                <?php foreach ($providers as $provider) { ?>
                  <?php if ($provider == $hybrid_auth['provider']) { ?>
                    <option value="<?php echo $provider; ?>" selected="selected"><?php echo $provider; ?></option>
                  <?php } else { ?>
                    <option value="<?php echo $provider; ?>"><?php echo $provider; ?></option>
                  <?php } ?>
                <?php } ?>
              </select>
            </td>
            <td class="left">
              <select name="hybrid_auth[<?php echo $row; ?>][enabled]" class="form-control">
                <?php if ($hybrid_auth['enabled']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </td>
            <td class="left"><input type="text" class="form-control" name="hybrid_auth[<?php echo $row; ?>][key]" value="<?php echo $hybrid_auth['key']; ?>" size="50" /></td>
            <td class="left"><input type="text" class="form-control" name="hybrid_auth[<?php echo $row; ?>][secret]" value="<?php echo $hybrid_auth['secret']; ?>" size="50" /></td>
            <td class="left"><input type="text" class="form-control" name="hybrid_auth[<?php echo $row; ?>][scope]" value="<?php echo $hybrid_auth['scope']; ?>" size="50" /></td>
            <td class="right"><input type="text" class="form-control" name="hybrid_auth[<?php echo $row; ?>][sort_order]" value="<?php echo $hybrid_auth['sort_order']; ?>" size="3" /></td>
            <td class="left"><button type="button" onclick="$('#row<?php echo $row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
          </tr>
        </tbody>
        <?php $row++; ?>
        <?php } ?>
        <tfoot>
          <tr>
            <td colspan="6"></td>
            <td class="left"><button type="button" onclick="addRow();" data-toggle="tooltip" title="<?php echo $button_add_row; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
          </tr>
        </tfoot>
      </table>
            </div>
          </div>

        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>

<script type="text/javascript"><!--
var row = <?php echo $row; ?>;

function addRow() {
	html  = '<tbody id="row' + row + '">';
	html += '  <tr>';
	html += '    <td class="left">';
  html += '      <select name="hybrid_auth[' + row + '][provider]" class="form-control">';
                 <?php foreach ($providers as $provider) { ?>
  html += '        <option value="<?php echo $provider; ?>"><?php echo $provider; ?></option>';
                 <?php } ?>
  html += '      </select>';
  html += '    </td>';
	html += '    <td class="left">';
  html += '      <select name="hybrid_auth[' + row + '][enabled]" class="form-control">';
  html += '        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
  html += '        <option value="0"><?php echo $text_disabled; ?></option>';
  html += '      </select>';
  html += '    </td>';
	html += '    <td class="left"><input type="text" class="form-control" name="hybrid_auth[' + row + '][key]" value="" size="50" /></td>';
	html += '    <td class="left"><input type="text" class="form-control" name="hybrid_auth[' + row + '][secret]" value="" size="50" /></td>';
	html += '    <td class="left"><input type="text" class="form-control" name="hybrid_auth[' + row + '][scope]" value="" size="50" /></td>';
	html += '    <td class="right"><input type="text" class="form-control" name="hybrid_auth[' + row + '][sort_order]" value="' + row + '" size="3" /></td>';
	html += '    <td class="left"><button type="button" onclick="$(\'#row<?php echo $row; ?>\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
	html += '  </tr>';
	html += '</tbody>';

	$('#module tfoot').before(html);

	row++;
}
//--></script>

<?php echo $footer; ?>
