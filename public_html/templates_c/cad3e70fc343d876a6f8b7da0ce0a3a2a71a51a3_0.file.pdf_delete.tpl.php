<?php
/* Smarty version 4.3.2, created on 2023-11-27 14:16:13
  from 'C:\xampp\htdocs\smarty_p_01\templates\pdf_delete.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '4.3.2',
  'unifunc' => 'content_6564261d6bf8c6_44845867',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'cad3e70fc343d876a6f8b7da0ce0a3a2a71a51a3' => 
    array (
      0 => 'C:\\xampp\\htdocs\\smarty_p_01\\templates\\pdf_delete.tpl',
      1 => 1701062166,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6564261d6bf8c6_44845867 (Smarty_Internal_Template $_smarty_tpl) {
?><!DOCTYPE html>
<html>
<head>
    <title>PDF 削除</title>

<body>

    <?php if ($_smarty_tpl->tpl_vars['PDF_Delete_Flg']->value === 1) {?>
        <p>削除完了しました。</p>
    <?php } elseif ($_smarty_tpl->tpl_vars['PDF_Delete_Flg']->value === 2) {?>
         <p>削除に失敗しました。（pathなどを確認してください）</p>
    <?php } else { ?>
        <p>削除に失敗しました。（POST 送信に失敗しました）</p>
    <?php }?>

</body>
</html>
<?php }
}
