<?php


// ======== function 
function lfSelectAkijokyoWK($conn, $sid, $y_kind, &$rows)
{
    $ret = false;

    // 空き状況照会ワークを取得
    $sql = "SELECT GYO_NO, YOYAKUBI, WAKU_NO, WAKU_AKI, WAKU_MAX,WAKU_ZUMI FROM AKIJOKYOWK WHERE SID = :sid AND Y_KIND = :yk ORDER BY GYO_NO, YOYAKUBI, WAKU_NO ASC";


    $sql = Ut_Utils::trim($sql);
    $stid = oci_parse(
        $conn,
        $sql
    );

    if (!$stid) {
        $e = oci_error($conn);
        self::fnDispError(DB_ERROR, $e['message'] . "::lfSelectAkijokyoWK", true, DEBUG_MODE);
    }
    oci_bind_by_name(
        $stid,
        ':sid',
        $sid
    );
    oci_bind_by_name(
        $stid,
        ':yk',
        $y_kind
    );
    $r = oci_execute($stid);
    if (!$r) {
        $e = oci_error($stid);
        self::fnDispError(DB_ERROR, $e['message'] . "::lfSelectAkijokyoWK_02", true, DEBUG_MODE);
    }

    $nrows = oci_fetch_all($stid, $rows, null, null, OCI_FETCHSTATEMENT_BY_ROW);

    // print_r($rows);

    if ($nrows > 0) {
        //Ut_Utils::printR($res);
        //Ut_Utils::printR($nrows);
        $ret = true;
    }

    oci_free_statement($stid);

    return $ret;
}

// ======== function END 

// ======== function

function lfSelectAkijokyoDate($conn, $sid, $y_kind, &$rows)
{
    $ret = false;

    // 空き状況照会ワークを取得
    $sql = "SELECT YOYAKUBI, ROKUYO, Y_KIND FROM AKIJOKYOWK WHERE SID = :sid AND Y_KIND = :yk GROUP BY YOYAKUBI, ROKUYO, Y_KIND ORDER BY YOYAKUBI ASC";
    $stid = oci_parse($conn, $sql);
    if (!$stid) {
        $e = oci_error($conn);
        self::fnDispError(DB_ERROR, $e['message'] . "::lfSelectAkijokyoDate", true, DEBUG_MODE);
    }
    oci_bind_by_name($stid, ':sid', $sid);
    oci_bind_by_name($stid, ':yk', $y_kind);
    $r = oci_execute($stid);
    if (!$r) {
        $e = oci_error($stid);
        self::fnDispError(DB_ERROR, $e['message'] . "::lfSelectAkijokyoDate", true, DEBUG_MODE);
    }

    $nrows = oci_fetch_all($stid, $rows, null, null, OCI_FETCHSTATEMENT_BY_ROW);


    if ($nrows > 0) {
        //Ut_Utils::printR($res);
        //Ut_Utils::printR($nrows);
        $ret = true;
    }

    oci_free_statement($stid);

    return $ret;
}

// ======== function END


$arrDate = array();

$arrReikyuu_Kasou = array(); // === 火葬　・　霊柩車
$arrTime_Reikyuu = array(); // === 火葬　・　霊柩車

$ret = $this->lfSelectAkijokyoDate($conn, $sid, $y_kind, $arrDate);
$y_kind = 'RKS'; // === 追加霊柩車
$ret = $this->lfSelectAkijokyoWK($conn, $sid, $y_kind, $arrReikyuu_Kasou);


// =========== 追記 霊柩車 夏目 01
foreach ($arrTime as $item) {
    $row = array();
    $row["GYO_NO"] = $item['GYO_NO'];
    $row["TIME_NO"] = $item['TIME_NO'];
    $row["TITLE"] = $item['TITLE'];

    $this->arrReikyuu_Kasou[] = $row;
}

// ======== 霊柩車 用　夏目 02
foreach ($arrReikyuu_Kasou as $item) {
    $gyo_no = $item['GYO_NO'];
    $row = array();
    $row["YOYAKUBI"] = $item['YOYAKUBI'];
    $row["WAKU_NO"] = $item['WAKU_NO'];
    $row["WAKU_AKI"] = $item['WAKU_AKI'];

    // === waku_max , waku_zumi 追加
    $row["WAKU_MAX"] = $item['WAKU_MAX'];
    $row["WAKU_ZUMI"] = $item['WAKU_ZUMI'];

    foreach ($this->arrReikyuu_Kasou as $k => $v) {
        if ($v["GYO_NO"] == $gyo_no) {

            $this->arrReikyuu_Kasou[$k]["INFO"][] = $row;
            break;
        }
    }
}
