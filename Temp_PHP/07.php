<?php


//===========================

/*

０パディング　＆　、　key と value 同じ　２次元配列作成


*/

$arrDeathTime_HYOUZI_V = array();

for ($i = 0; $i <= 23; $i++) {
    //$hour = str_pad($i, 2, '0', STR_PAD_LEFT);

    for ($j = 0; $j <= 59; $j++) {
        // 分が1桁の場合、0埋めして2桁にする
        $minute = str_pad($j, 2, '0', STR_PAD_LEFT);

        // 時間と分を連結して配列に追加
        $arrDeathTime_HYOUZI_V[] = $i . ":" . $minute;
    }
}

$arr_Death_Time = array();

// ========= ２次元配列で、key と　値を同じにする
foreach ($arrDeathTime_HYOUZI_V as $val) {
    $idx = $val;
    $arr_Death_Time[$idx] = $val;
}

$this->arrDeathTime_HYOUZI = $arr_Death_Time;

//===========================

/*

時間の 0パディング

00:00

12:59

*/

$arrDeathTime_H_02 = array();

for ($i = 0; $i <= 23; $i++) {
    $hour = str_pad($i, 2, '0', STR_PAD_LEFT);
    for ($j = 0; $j <= 59; $j++) {
        // 分が1桁の場合、0埋めして2桁にする
        $minute = str_pad($j, 2, '0', STR_PAD_LEFT);

        // 時間と分を連結して配列に追加
        $arrDeathTime_H_02[] = $hour . $minute;
    }
}

// 結果を表示
print_r($arrDeathTime_H_02);
