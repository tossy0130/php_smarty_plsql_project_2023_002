<?php


// ============================================================== 01
/*

========= 値取得 =========

trim(fgets(STDIN));

fscanf(STDIN,"%d %d",$a,$b);

[$a, $b] = explode(' ', trim(fgets(STDIN)));

*/

$num_01 = trim(fgets(STDIN));

for ($i = 0; $i < $num_01; $i++) {
    $arr_01[] = trim(fgets(STDIN));
}

// === ソート ロジック
for ($i = 0; $i < count($arr_01); $i++) {

    for ($j = 1; $j < count($arr_01); $j++) {
        if ($arr_01[$j - 1] > $arr_01[$j]) {
            $tmp = $arr_01[$j - 1];
            $arr_01[$j - 1] = $arr_01[$j];
            $arr_01[$j] = $tmp;
        }
    }
}

// === 出力
foreach ($arr_01 as $val_01) {
    print($val_01 . "\n");
}
