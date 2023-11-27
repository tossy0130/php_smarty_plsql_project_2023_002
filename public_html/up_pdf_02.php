<?php

ini_set('display_errors', 1);

require_once('../vendor/autoload.php');
require_once('../class/db.php');

require('../class/constant.php'); // 定数クラス

// Smartyオブジェクトを作成
$smarty = new Smarty;
$smarty->template_dir = '../templates/';

$smarty->display('../templates/upload.tpl');


$uncPath = '\\\\192.168.254.18\\jim2\\maebashi_pdf_test_f\\uploads';

if (file_exists($uncPath)) {
    echo "ディレクトリは既に存在します。";
} else {
    if (mkdir($uncPath, 0777, true)) {
        echo "ディレクトリが作成されました。";
    } else {
        echo "ディレクトリの作成に失敗しました。";
    }
}
