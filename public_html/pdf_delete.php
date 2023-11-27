<?php

ini_set('display_errors', 1);

require_once('../vendor/autoload.php');
require_once('../class/db.php');

require('../class/constant.php'); // 定数クラス

// Smartyオブジェクトを作成
$smarty = new Smarty;
$smarty->template_dir = '../templates/';

$pdfDirectory = './uploads/';

$PDF_Delete_Flg = 0;

// PDF削除
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['delete_pdf'])) {
    $pdfToDelete = $_POST['delete_pdf'];

    // パスのバリデーションなどが必要
    $pdfToDeletePath = $pdfDirectory . '/' . $pdfToDelete . ".pdf";

    // === 削除
    if (file_exists($pdfToDeletePath)) {
        unlink($pdfToDeletePath);
        $PDF_Delete_Flg = 1;
        
    } else {
        // 削除失敗
        $PDF_Delete_Flg = 2;
    }
} else {
    // 削除失敗
    $PDF_Delete_Flg = 3;
}

$smarty->assign('PDF_Delete_Flg', $PDF_Delete_Flg);
$smarty->display('../templates/pdf_delete.tpl');
