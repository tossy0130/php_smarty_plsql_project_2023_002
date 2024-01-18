<?php


//========================= key 700 , value 7:00 , key 2050, value 20:50
$arr_car_tmp = array();
$idx = 0;

for ($i = 7; $i <= 20; $i++) {
    for ($j = 0; $j <= 50; $j += 10) {
        $value = $i . $j;

        // === 7 ~ 9　時の場合
        if ($i < 10) {
            // ３桁にして 後ろを 0埋め
            $value = str_pad($value, 3, "0", STR_PAD_BOTH);
            //            $value = "0" . $value;

            // === 10時 以上で 、分が 0の場合  
        } else if ($i >= 10 && $j == 0) {
            $value = $value . "0";

            // === 10時 以上で、分が 0じゃない場合
        } else if ($i >= 10) {
            $value = $value;
        }

        $value = substr_replace($value, ':', -2, 0);

        $arr_car_tmp[$idx] = $value;
        $idx++;
    }
}

$arr_car_r = array();
foreach ($arr_car_tmp as $val) {
    $key = $val;
    $key = str_replace(':', '', $key);
    $arr_car_r[$key] = $val;
}

print_r($arr_car_r);
