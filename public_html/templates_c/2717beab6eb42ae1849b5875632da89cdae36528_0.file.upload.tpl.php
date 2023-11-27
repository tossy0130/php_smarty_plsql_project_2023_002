<?php
/* Smarty version 4.3.2, created on 2023-11-24 13:52:32
  from 'C:\xampp\htdocs\smarty_p_01\templates\upload.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '4.3.2',
  'unifunc' => 'content_65602c10095358_51074929',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '2717beab6eb42ae1849b5875632da89cdae36528' => 
    array (
      0 => 'C:\\xampp\\htdocs\\smarty_p_01\\templates\\upload.tpl',
      1 => 1698821681,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_65602c10095358_51074929 (Smarty_Internal_Template $_smarty_tpl) {
?><!DOCTYPE html>
<html>
<head>
  <title>PDFファイルアップロード</title>
</head>
<body>
  <h1>PDFファイルをアップロード</h1>
  <form action="./upload.php" method="post" enctype="multipart/form-data">
    <label for="pdfFile">PDFファイルを選択:</label>
    <input type="file" name="pdfFile" id="pdfFile" accept=".pdf">
    <br>
    <input type="submit" value="アップロード">
  </form>
</body>
</html>
<?php }
}
