<?php


//===================== ２次元配列　重複データ削除

$tempArray = array();
$resultArray = array();

foreach ($arrRsv as $item) {
    $kojinName = $item['KOJIN_NAME'];

    // 一時的な配列に"KOJIN_NAME"が存在しない場合、結果配列に追加
    if (!in_array($kojinName, $tempArray)) {
        $tempArray[] = $kojinName;
        $resultArray[] = $item;
    }
}

// 結果を表示
print_r($resultArray);
$arrRsv = $resultArray;



print($arrRsv[0]['KOJIN_NAME']);
print($arrRsv[1]['KOJIN_NAME']);
print($arrRsv[2]['KOJIN_NAME']);
print($arrRsv[3]['KOJIN_NAME']);
