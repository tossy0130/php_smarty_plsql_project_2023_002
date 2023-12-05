<?php

//=================== スマーティー　ラジオボタン用

$arr_Kasou_k = array();
$arr_Kasou_k_Name = array();

$idx = 0;
foreach ($res as $k_val) {
    $arr_Kasou_k[$idx] = $k_val['火葬区分'];
    $arr_Kasou_k_Name[$idx] = $k_val['区分名'];
    $idx += 1;
}

if (
    $nrows > 0
) {
    //Ut_Utils::printR($res);
    $this->arrKsou_K = $arr_Kasou_k_Name;
}
