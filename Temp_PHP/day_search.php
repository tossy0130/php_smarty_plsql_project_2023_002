<?php
/*
 * This file is part of SAIJYO WEB YOYAKU SYSTEM
*
* Copyright(c) Oriental CO.,LTD. All Rights Reserved.
*
* uri: http://oriental-soft.jp/
* email: info@oriental-soft.jp
*/
require_once './common.php';
require_once CLASS_PATH . '/Base_Page.php';


/**
 *  日別照会 クラス
 */
class Day_search extends Base_Page
{

    /**
     * Page を初期化する.
     *
     * @return void
     */
    function init()
    {
        parent::init();
        $this->setTemplate('day_search.tpl');
    }

    /**
     * Page のプロセス.
     *
     * @return void
     */

    function process($checkToken = false)
    {
        parent::process();
        $this->action();
        $this->sendResponse($this);
    }


    /**
     * Page のアクション.
     *
     * @return void
     */
    function action()
    {
        // パラメーター管理クラス
        $objFormParam = new Base_FormParam();

        // パラメーター情報の初期化
        $this->lfInitParam($objFormParam);

        // 値の設定
        $objFormParam->setParam($_REQUEST);

        // 入力値の変換
        $objFormParam->convParam();

        // 値の取得
        $this->arrForm = $objFormParam->getHashArray();

        //modeの取得
        $this->mode = $this->getMode();

        switch ($this->getMode()) {
            case 'logout':
                $this->lfDoLogout();
                $this->response->sendRedirect('login.php', array(), false, true);
                break;

            case 'view_list':
                $this->response->sendRedirect('view_list.php');
                break;

            case 'reserve_list':
                $this->response->sendRedirect('reserve_list.php', array(), false, true);
                break;

                // === 追加 23_11_01
                // ====== 画像アップロード
            case 'upload_edit':
                $this->response->sendRedirect('upload_edit.php', array(), false, true);
                break;

                // === 追加 23_11_02
                // ====== PDF プレビュー
            case 'generate_pdf':
                $this->response->sendRedirect('generate_pdf.php', array(), false, true);
                break;

                // === 追加 23_11_24
            case 'pdf_view':
                $this->View_Post();
                $this->response->sendRedirect('pdf_view.php', array(), false, true);
                break;

            case 'reserve_edit':
                $this->lfSetYoyakuKeys($objFormParam);
                $arrQueryString = array("mode" => $this->getMode());
                $this->response->sendRedirect('reserve_edit.php', $arrQueryString, false, true);

                break;
            case 'reload':
            default:

                $this->doDefault($objFormParam);
                //    $this->PDF_UPCHK();
                $this->GET_Gyousya_KB(); // === 業者区分　追加
                $this->lfSetYoyakuKeys($objFormParam);
                break;
        }
    }

    /**
     * パラメーター情報の初期化
     *
     * @param  array $objFormParam フォームパラメータークラス
     * @return void
     */
    public function lfInitParam(&$objFormParam)
    {
        // 予約IDの取得
        $objFormParam->addParam('受付年度', 'UKE_NEND', 4, '', array('EXIST_CHECK', 'ALNUM_CHECK', 'MAX_LENGTH_CHECK'));
        $objFormParam->addParam('受付番号', 'UKE_NO', 4, '', array('EXIST_CHECK', 'ALNUM_CHECK', 'MAX_LENGTH_CHECK'));
        $objFormParam->addParam('火葬予約日時', 'YOYAKUBI_STRING', 20, '', array('EXIST_CHECK', 'MAX_LENGTH_CHECK'));

        $device = $this->detectDevice();
        if ($device == DEVICE_TYPE_SMARTPHONE) {
            $objFormParam->addParam('索引番号IDX', 'gyono_idx', 4, '', array('MAX_LENGTH_CHECK'));
        }
    }


    public function lfDoLogout()
    {
        // ログイン記録ログ出力
        $user_id = $_SESSION['user_id'];
        $gyosya_number = $_SESSION['gyosya_number'];
        $sid = $this->session->getSid();
        $str_log = "logout: user=$user_id($gyosya_number) sid=$sid";
        //		Ut_Logs::printLog($str_log);

        // === セッション削除
        $this->session->destroy();
    }

    //予約キー情報セット
    function lfSetYoyakuKeys(&$objFormParam)
    {
        $form = $objFormParam->getHashArray();

        foreach ($form as $key => $val) {

            $this->session->setSession($key, $val);
        }
    }

    //予約キー情報リセット
    function lfResetYoyakuKeys(&$objFormParam)
    {
        $form = $objFormParam->getHashArray();
        foreach ($form as $key => $val) {
            $this->session->deleteSession($key);
        }
        // bug fix date141023


        $this->session->deleteSession("YOYAKUBI");
        $this->session->deleteSession("WAKU_NO");
        $this->session->deleteSession("YOYAKU_TIME");
    }

    function doDefault(&$objFormParam)
    {

        $this->disp_flag = 0;

        // ログイン判定
        if ($this->isLoginSuccess() === true) {
            $this->tpl_login = true;

            $this->disp_flag = 1;
        } else {
            $this->response->sendRedirect('login.php', array(), false, true);
        }

        // 端末判定
        $device = $this->detectDevice();

        // 予約キー情報リセット
        $this->lfResetYoyakuKeys($objFormParam);

        // 今日の日付
        $this->current_datetime = Ut_Date::getCurrentDateTimeString();

        $sid = $this->session->getSid();
        $gyosya_number = $this->session->getSession("gyosya_number");
        $ansyo_number = $this->session->getSession("ansyo_number");
        $this->gyosya_name = $this->session->getSession("gyosya_name");

        // === 追加　業者番号　追加 23_1102　夏目
        $this->gyosya_number = $this->session->getSession("gyosya_number");

        $this->uke_nend = $this->session->getSession("UKE_NEND");


        if ($_SERVER['REQUEST_METHOD'] == 'POST') {

            if (isset($_POST['day_val'])) {

                $selectedDate = $_POST['day_val'];

                // OCI
                $conn = oci_connect(DB_USER, DB_PASSWORD, DB_CONNECTION_STRING, DB_CHARSET);

                if (!$conn) {
                    $e = oci_error();
                    self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
                }

                //   $sql = "SELECT 受付番号,申請者姓, 申請者名, 死亡者姓, 死亡者名, 火葬区分,予約日付,式場利用区分,通夜利用区分,霊きゅう車利用区分,受付担当者,業者名 FROM 火葬受付 WHERE 予約日付 = :selectedDate";

                // SQL文

                /*
                $sql = "SELECT Ka.受付番号, Ka.申請者姓, Ka.申請者名, Ka.死亡者姓, Ka.死亡者名, Ka.火葬区分, Ka.予約日付, Ka.式場利用区分, Ka.通夜利用区分, Ka.霊きゅう車利用区分, Ka.受付担当者, Ka.業者名,Ka.受付区分, Ka.窓口区分, Pd.ファイルパス
FROM 火葬受付 Ka
LEFT JOIN PDF_UPDETA Pd ON Ka.受付番号 = Pd.受付番号 AND Ka.予約日付 = Pd.予約日付
WHERE Ka.予約日付 = :selectedDate OR (Pd.受付番号 IS NULL AND Ka.予約日付 = :selectedDate) AND Ka.受付区分 in (0,1)
ORDER BY Ka.受付番号 ASC";
                */

                $sql = "SELECT Ka.受付番号, Ka.申請者姓, Ka.申請者名, Ka.死亡者姓, Ka.死亡者名, Ka.火葬区分, Ka.予約日付, Ka.式場利用区分, Ka.通夜利用区分, Ka.霊きゅう車利用区分, Ka.受付担当者, Ka.業者名,Ka.受付区分, Ka.窓口区分, Pd.ファイルパス,Dt.申請者姓, Dt.申請者名, Dt.死亡者姓, Dt.死亡者名
FROM 火葬受付 Ka
LEFT JOIN PDF_UPDETA Pd ON Ka.受付番号 = Pd.受付番号 AND Ka.予約日付 = Pd.予約日付
LEFT JOIN 火葬台帳 Dt ON Ka.受付番号 = Dt.受付番号 AND Ka.予約日付 = Dt.予約日付
WHERE Ka.予約日付 = :selectedDate OR (Pd.受付番号 IS NULL AND Ka.予約日付 = :selectedDate) AND Ka.受付区分 in (0,1)
ORDER BY Ka.受付番号 ASC";

                $stid = oci_parse($conn, $sql);
                if (!$stid) {
                    $e = oci_error($conn);
                    self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
                }

                oci_bind_by_name($stid, ":selectedDate", $selectedDate);

                $r = oci_execute($stid);
                if (!$r) {
                    $e = oci_error($stid);
                    self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
                }

                /*
                $nrows = oci_fetch_all($stid, $day_data, null, null, OCI_FETCHSTATEMENT_BY_ROW);

                if ($nrows > 0) {
                    //Ut_Utils::printR($res);
                    // Ut_Utils::printR($nrows);
                    $ret = true;
                }

                print_r("出力:::" . $day_data);
                */

                $day_data = array();
                while ($row = oci_fetch_assoc($stid)) {
                    $day_data[] = $row;
                }

                $arr_get_search = array();

                $arr_val_01_tmp = array(); // 受付番号

                $arr_sinseisya_sei = array(); // 申請者姓
                $arr_sinseisya_mei = array(); // 申請者名
                $arr_val_02_tmp = array(); // 申請者姓 + 申請者名

                $arr_sibousya_sei = array(); // 死亡者姓
                $arr_sibousya_mei = array(); // 死亡者名
                $arr_val_03_tmp = array();   // 死亡者姓 + 死亡者名

                $arr_val_04_tmp = array(); // 火葬区分
                $arr_val_05_tmp = array(); // 予約日
                $arr_val_06_tmp = array(); // 式場 利用
                $arr_val_07_tmp = array(); // 通夜式 利用
                $arr_val_08_tmp = array(); // 霊柩車 利用
                $arr_val_09_tmp = array(); // 受付担当者
                $arr_val_10_tmp = array(); // 業者名

                $arr_val_11_tmp = array(); // 受付区分

                $arr_val_12_tmp = array(); // 窓口区分 
                $arr_val_13_tmp = array(); // ファイルパス

                $arr_val_14_tmp = array(); // 申請者姓
                $arr_val_15_tmp = array(); // 申請者名
                $arr_val_16_tmp = array(); // 死亡者姓
                $arr_val_17_tmp = array(); // 死亡者名


                $arr_idx_tmp = array();
                $arr_idx_NUM_tmp = array();

                $idx = 0;
                foreach ($day_data as $row) {
                    //  echo "受付番号: " . $row['受付番号'] . ", 予約日付: " . $row['予約日付'] . ",火葬区分:" . $row['火葬区分'] . "<br>";
                    $arr_val_01_tmp[$idx] = $row['受付番号'];

                    $arr_sinseisya_sei[$idx] = $row['申請者姓'];
                    $arr_sinseisya_mei[$idx] = $row['申請者名'];
                    // === 申請者姓 + 申請者名
                    $arr_val_02_tmp[$idx] = $arr_sinseisya_sei[$idx] . " " . $arr_sinseisya_mei[$idx];

                    $arr_sibousya_sei[$idx] = $row['死亡者姓'];
                    $arr_sibousya_mei[$idx] = $row['死亡者名'];
                    // === 死亡者姓 + 死亡者名
                    $arr_val_03_tmp[$idx] = $arr_sibousya_sei[$idx] . " " . $arr_sibousya_mei[$idx];

                    $arr_val_04_tmp[$idx] = $row['火葬区分'];

                    $formatted_date = date("Y年n月j日", strtotime($row['予約日付']));
                    $arr_val_05_tmp[$idx] = $formatted_date;

                    $arr_val_06_tmp[$idx] = $row['式場利用区分'];
                    $arr_val_07_tmp[$idx] = $row['通夜利用区分'];
                    $arr_val_08_tmp[$idx] = $row['霊きゅう車利用区分'];
                    $arr_val_09_tmp[$idx] = $row['受付担当者'];
                    $arr_val_10_tmp[$idx] = $row['業者名'];

                    $arr_val_11_tmp[$idx] = $row['受付区分'];
                    $arr_val_12_tmp[$idx] = $row['窓口区分'];

                    $arr_val_13_tmp[$idx] = $row['ファイルパス'];

                    $arr_val_14_tmp[$idx] = $row['申請者姓'];
                    $arr_val_15_tmp[$idx] = $row['申請者名'];
                    $arr_val_16_tmp[$idx] = $row['死亡者姓'];
                    $arr_val_17_tmp[$idx] = $row['死亡者名'];

                    $arr_idx_tmp[$idx] = $idx;
                    $arr_idx_NUM_tmp[$idx] = $idx + 1;
                    $idx = $idx + 1;
                }

                $this->arr_idx = $arr_idx_tmp;
                $this->arr_idx_NUM = $arr_idx_NUM_tmp;

                // === 出力データ
                $this->arr_val_01 = $arr_val_01_tmp;
                $this->arr_val_02 = $arr_val_02_tmp;
                $this->arr_val_03 = $arr_val_03_tmp;
                $this->arr_val_04 = $arr_val_04_tmp;
                $this->arr_val_05 = $arr_val_05_tmp;
                $this->arr_val_06 = $arr_val_06_tmp;
                $this->arr_val_07 = $arr_val_07_tmp;
                $this->arr_val_08 = $arr_val_08_tmp;
                $this->arr_val_09 = $arr_val_09_tmp;
                $this->arr_val_10 = $arr_val_10_tmp;

                $this->arr_val_11 = $arr_val_11_tmp;
                $this->arr_val_12 = $arr_val_12_tmp;
                $this->arr_val_13 = $arr_val_13_tmp;

                $this->arr_val_14 = $arr_val_14_tmp;
                $this->arr_val_15 = $arr_val_15_tmp;
                $this->arr_val_16 = $arr_val_16_tmp;
                $this->arr_val_17 = $arr_val_17_tmp;

                // === 受付番号 件数の重複を削除して、当日の件数を表示用に加工
                $uniqueArr_Uketuke = array_unique($arr_val_01_tmp);
                $Count_Uketuke = count($uniqueArr_Uketuke);
                $this->Count_Uketuke_val = $Count_Uketuke;

                oci_free_statement($stid);


                oci_close($conn);
            } else {
                echo "日付が選択されていません。";
            }
        }
    }




    /**
     *   ========= 追加 23_1124 夏目 =========
     */
    function View_Post()
    {

        $sid = $this->session->getSid();
        $gyosya_number = $this->session->getSession("gyosya_number");
        $gyosya_name = $this->session->getSession("gyosya_name");

        $this->gyosya_number_v = $gyosya_number;
        $this->gyosya_name_v = $gyosya_name;
    }


    /**
     *  業者区分 取得 （前橋用）追加 夏目
     */
    function GET_Gyousya_KB()
    {

        $gyosya_number = $this->session->getSession("gyosya_number");
        $ansyo_number = $this->session->getSession("ansyo_number");
        $gyosya_name = $this->session->getSession("gyosya_name");


        // OCI
        $conn = oci_connect(DB_USER, DB_PASSWORD, DB_CONNECTION_STRING, DB_CHARSET);

        if (!$conn) {
            $e = oci_error();
            self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
        }

        $sql = "SELECT 業者略称, 受付区分 FROM 業者 WHERE 業者コード = :gyosya_number AND 業者名 = :gyosya_name";

        $stid = oci_parse($conn, $sql);
        if (!$stid) {
            $e = oci_error($stid);
            self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
        }

        oci_bind_by_name($stid, ':gyosya_number', $gyosya_number);
        oci_bind_by_name($stid, ':gyosya_name', $gyosya_name);

        $r = oci_execute($stid);
        if (!$r) {
            $e = oci_error($stid);
            self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
        }

        $nrows = oci_fetch_all($stid, $gyou_kb, null, null, OCI_FETCHSTATEMENT_BY_ROW);

        // === 業者区分 格納用
        $arr_Gyousya_KB = array();

        // 
        if (isset($gyou_kb[0])) {
            $GET_gyousya_ryaku_name = $gyou_kb[0]['業者略称'];
            $GET_gyousya_uke_kb = $gyou_kb[0]['受付区分'];

            $_SESSION['GET_gyousya_ryaku_name'] = $GET_gyousya_ryaku_name;
            $_SESSION['GET_gyousya_uke_kb'] = $GET_gyousya_uke_kb;
        }


        if ($nrows > 0) {
            //Ut_Utils::printR($res);
            // Ut_Utils::printR($nrows);
            $ret = true;
        }

        oci_free_statement($stid);
        oci_close($conn);
    } // ========= END function 

}

$objPage = new Day_search();
$objPage->init();
$objPage->process();
