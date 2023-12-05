<?php


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
