<?php
/* Smarty version 4.3.2, created on 2023-11-27 14:23:48
  from 'C:\xampp\htdocs\smarty_p_01\templates\view_pdf.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '4.3.2',
  'unifunc' => 'content_656427e4d5b1c4_78292614',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '683a7cc124b9e97e77c58f6a11a9d8f04506f442' => 
    array (
      0 => 'C:\\xampp\\htdocs\\smarty_p_01\\templates\\view_pdf.tpl',
      1 => 1701062627,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_656427e4d5b1c4_78292614 (Smarty_Internal_Template $_smarty_tpl) {
?><!DOCTYPE html>
<html>
<head>
    <title>PDF 表示一覧</title>

<body>

<p>
     view_pdf 表示<br />

     <a href="../public_html/index.php">TOP</a>
</p>

 <table class="list">
                <col width="40%" />
                <col width="40%" />
                 <tr>
                    <th class="alignL">ファイル名</th>
                    <th class="alignL">PDFを確認</th>
                 </tr>

<?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['arr_pdf_v']->value, 'pdf_val');
$_smarty_tpl->tpl_vars['pdf_val']->do_else = true;
if ($_from !== null) foreach ($_from as $_smarty_tpl->tpl_vars['pdf_val']->value) {
$_smarty_tpl->tpl_vars['pdf_val']->do_else = false;
?> 
            <tr>
                <td class="alignL">
                    <?php echo $_smarty_tpl->tpl_vars['pdf_val']->value['PDF_NAME'];?>

                </td>

                <td class="alignL">
                    <a href="<?php echo $_smarty_tpl->tpl_vars['pdf_val']->value['PDF_PATH'];?>
" target="_blank">PDFを表示</a>
                <td class="alignL">

                <td>
                    <form method="post" action="../public_html/pdf_delete.php">
                            <input type="hidden" name="delete_pdf" value="<?php echo $_smarty_tpl->tpl_vars['pdf_val']->value['PDF_NAME'];?>
">
                        <button type="submit">削除</button>
                    </form>
                </td>

             </td>
<?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    
</table>

</body>
</html>

<?php }
}
