	<?php

    // =====================================
    // ============= 追加　夏目 23_1120
    // =====================================

    $BIG_title_gozen = ""; // === 大見出し（午前）
    $BIG_title_gogo = ""; // === 大見出し（午後）
    $BIG_title_zenniti = ""; // === 全日

    foreach ($arrSiki_Date as $val) {
        $gyo_no = $val['GYO_NO'];
        $row = array();
        $row["GYO_NO"] = $val["GYO_NO"];
        $row["TIME_NO"] = $val["TIME_NO"];

        // === 午前　大タイトル
        if (false !== strpos($val["TITLE"], "午前")) {
            $BIG_title_gozen = "午前";
        }

        // === 午後 大タイトル
        if (false !== strpos($val["TITLE"], "午後")) {
            $BIG_title_gogo = "午後";
        }

        // === 午後 大タイトル
        if (false !== strpos($val["TITLE"], "全日")) {
            $BIG_title_zenniti = "全日";
        }

        // ====== 中見出し作成
        $pattern = '/(?:午前|午後|全日)\s+([^\s]+)/u';

        if (preg_match($pattern, $val["TITLE"], $matches)) {
            print($matches[1]);

            $row["TITLE"] = $matches[1];
        }

        // $row["TITLE"] = $val["TITLE"];


        $this->arrShiki_Data[] = $row;
    }

    // === 大見出し 午前
    if (isset($BIG_title_gozen)) {
        if (!empty($BIG_title_gozen)) {
            $this->BIG_title_gozen_v = $BIG_title_gozen;
        }
    }

    // === 大見出し 午後
    if (isset($BIG_title_gogo)) {
        if (!empty($BIG_title_gogo)) {
            $this->BIG_title_gogo_v = $BIG_title_gogo;
        }
    }

    // === 大見出し 全日
    if (isset($BIG_title_zenniti)) {
        if (!empty($BIG_title_zenniti)) {
            $this->BIG_title_zenniti_v = $BIG_title_zenniti;
        }
    }

    foreach ($arrSiki_T as $val) {
        $gyo_no = $val['GYO_NO'];
        $row = array();
        $row["YOYAKUBI"] = $val['YOYAKUBI'];
        $row["WAKU_NO"] = $val['WAKU_NO'];
        $row["WAKU_AKI"] = $val['WAKU_AKI'];

        foreach ($this->arrShiki_Data as $k => $v) {
            if ($v["GYO_NO"] == $gyo_no) {

                $this->arrShiki_Data[$k]["INFO"][] = $row;
                break;
            }
        }
    }


    // =====================================
    // ============= 追加　夏目 23_1120 END
    // =====================================


    ?>