<?php

ini_set('display_errors', 1);

require_once('../vendor/autoload.php');
require_once('../class/db.php');

require('../class/constant.php'); // 定数クラス

// Smartyオブジェクトを作成
$smarty = new Smarty;
$smarty->template_dir = '../templates/';

$pdfDirectory = './uploads/';


$arr_pdf_v = array();
// ================================================ PDF 処理
// === PDF 表示用
$pdfFiles = glob($pdfDirectory . '/*.pdf');

// === 結果格納
foreach ($pdfFiles as $pdfpath) {
    $arr_pdf = array();
    $tmp_arr = pathinfo($pdfpath);

    $tmp_path = $tmp_arr['dirname'];
    $arr_pdf['PDF_PATH'] = $tmp_path . '/' . $tmp_arr['filename'] . ".pdf";
    $arr_pdf['PDF_NAME'] = $tmp_arr['filename'];

    $arr_pdf_v[] = $arr_pdf;
}


// === ここで、 $this->arr_pdf_v[] = $arr_pdf;　を渡す
// $smarty->assign('pdfFiles', $pdfFiles);

$smarty->assign('pdfFiles', $pdfFiles);
$smarty->assign('arr_pdf_v', $arr_pdf_v);

$smarty->display('../templates/view_pdf.tpl');
