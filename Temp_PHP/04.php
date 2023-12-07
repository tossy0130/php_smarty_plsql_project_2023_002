<?php


$yoyakubi = "23-12-07";
$date = DateTime::createFromFormat('y-m-d', $yoyakubi);
// 新しいフォーマットで日付を出力
$yoyakubi_f = $date->format('Y-m-d');
print($yoyakubi_f);

//=======================================
// ================== 出力 2023年12月01日
//=======================================
$yoyakubi_02 = "23-12-01";
$date_02 = DateTime::createFromFormat('y-m-d', $yoyakubi);

$yoyakubi_f = $date->format('Y年m月d日');

print("\n");
print($yoyakubi_f);
print("\n");

// =======================================
// === 追記　夏目 23_1204
// =======================================
$yoyakubi_Flg = 0;

if (strpos($this->yoyakubi_string, "1970年") !== false) {
    $yoyaku_str = DateTime::createFromFormat('y-m-d', $yoyakubi);
    $yoyakubi_f = $yoyaku_str->format('Y年m月d日w');

    // 曜日を追加して表示
    $this->yoyakubi_string = $yoyakubi_f;
    $this->yoyakubi_Flg = 1;
} else {

    // === 通常処理
    $this->yoyakubi_Flg = 0;
}
// === 追記　夏目 23_1204 END
