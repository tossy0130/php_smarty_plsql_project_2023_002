<?php
/*

*/
require_once './common.php';
require_once CLASS_PATH . '/child/Ch_Reserve.php';


/**
 * 予約編集クラス
 */
class Reserve_Edit extends Ch_Reserve
{
	/**
	 * Page を初期化する.
	 *
	 * @return void
	 */

	// === 追加
	private $arrZiin_val;

	private $arrSyukan_Place;

	function init()
	{
		parent::init();
		$this->setTemplate('reserve_edit.tpl');
		// フォーム情報の初期化
		$this->fnInitForm();

		//戻るボタン用
		$this->tpl_prev_url = $this->session->getPrevURL();

		// === 追加 23_1128
		$yoyakubi = $this->session->getSession("YOYAKUBI");
		$waku_no  = $this->session->getSession("WAKU_NO");

		//	print($waku_no);


		/*
		if (mb_strlen($waku_no) <= 3) {
			// === 式場
			if ($waku_no == 120 || $waku_no == 220) {
				$this->shiki_type = 1;
			} else {
				$this->shiki_type = 2;
			}
		} else {
			$this->shiki_type = 0;
		}*/

		$shiki_type_v = 0;
		switch ($waku_no) { // switch文の始まり
			case 100:
				$shiki_type_v = 1;
				$this->shiki_type = $shiki_type_v;
				break;
			case 120:
				$shiki_type_v = 1;
				$this->shiki_type = $shiki_type_v;
				break;
			case 121:
				$shiki_type_v = 2;
				$this->shiki_type = $shiki_type_v;
				break;
			case 122:
				$shiki_type_v = 2;
				$this->shiki_type = $shiki_type_v;
				break;
			case 123:
				$shiki_type_v = 2;
				$this->shiki_type = $shiki_type_v;
				break;
			case 200:
				$shiki_type_v = 1;
				$this->shiki_type = $shiki_type_v;
				break;
			case 220:
				$shiki_type_v = 1;
				$this->shiki_type = $shiki_type_v;
				break;
			case 221:
				$shiki_type_v = 2;
				$this->shiki_type = $shiki_type_v;
				break;
			case 222:
				$shiki_type_v = 2;
				$this->shiki_type = $shiki_type_v;
				break;
			case 223:
				$shiki_type_v = 2;
				$this->shiki_type = $shiki_type_v;
				break;
			case 300:
				$shiki_type_v = 1;
				$this->shiki_type = $shiki_type_v;
				break;
			default:
				$shiki_type_v = 0;
		}


		/*
		$yoyaku_time = $this->session->getSession("YOYAKU_TIME");
		$shiki_type_v = $this->session->getSession("shiki_type");
		*/

		$kasou_type_g = $this->session->getSession("kasou_type");

		if ($kasou_type_g == 0) {
			$kasou_type_g = 0;
			$this->kasou_type = $kasou_type_g;
			//	print("if::火葬タイプ：12歳以上：" . $kasou_type . "<br />");
		} else if ($kasou_type_g == 1) {
			$kasou_type_g = 1;
			$this->kasou_type = $kasou_type_g;
			//	print("else if::火葬タイプ：12歳以下：" . $kasou_type . "<br />");
		} else if ($kasou_type_g == 2) {
			$kasou_type_g = 2;
			$this->kasou_type = $kasou_type_g;
			//	print("else::火葬タイプ：死産児：" . $kasou_type . "<br />");
		} else {
			$kasou_type_g = 11;
			$this->kasou_type = $kasou_type_g;
		}

		// print("shiki_type_v:::" . $shiki_type_v);

	}

	/**
	 * Page のプロセス.
	 *
	 * @return void
	 */
	function process($checkToken = false)
	{
		$chkToken = true;
		parent::process($chkToken);
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

		// modeの取得
		$this->mode = $this->getMode();

		// 入力フォームは常に表示
		$this->dispDetailFlag = 1;

		// ログイン判定
		if ($this->isLoginSuccess() === true) {
			$this->tpl_login = true;
		} else {
			$this->response->sendRedirect('login.php', array(), false, true);
		}

		switch ($this->getMode()) {
			case 'return':

				break;
			case 'logout':
				$this->fnDoLogout();
				$this->response->sendRedirect('login.php', array(), false, true);
				break;
			case 'view_list':
				$this->response->sendRedirect('view_list.php');
				break;
			case 'reserve_list':
				$this->response->sendRedirect('reserve_list.php', array(), false, true);
				break;
			case 'reserve_edit':  //=== *** 既存編集 ***
			case 'reserve_cancel':

				$this->SELECT_ITEM(); // === 編集
				$this->GET_KASOU_KUBUN(); // === 火葬区分

				$this->GET_SIBOU_TIME();

				$this->GET_YOUSIKI();
				$this->GET_ZIIN();
				$this->GET_SYUKAN();
				$this->GET_KOZIN_ZOKU();
				$this->SIBOU_PLACE();
				//	$this->GET_RENRAKU_ZIKOU();

				$ret = $this->doRead($objFormParam);
				break;
			case 'entry_confirm':
			case 'edit_confirm':
			case 'cancel_confirm':

				// === テスト
				$this->SELECT_ITEM(); // === 編集
				$this->GET_KASOU_KUBUN(); // === 火葬区分

				// === 死亡時刻 	
				//	$this->GET_SIBOU_TIME();

				$ret = $this->doConfirm($objFormParam);

				// print_r($objFormParam);

				if ($ret == true) {
					$arrQueryString = array("mode" => $this->getMode());
					$this->response->sendRedirect('reserve_confirm.php', $arrQueryString, false, true);
				} else {
					// === 追加
					$this->SELECT_ITEM(); // === 編集
					$this->GET_KASOU_KUBUN();

					// === 死亡時刻 	
					//	$this->GET_SIBOU_TIME();


					if (empty($this->tpl_error)) {
						$this->tpl_error = "入力エラーがありました。";
					}
				}
				break;
				//2014/12/16 ここから JIM 元川
			case 'reserve_edit_r':
			case 'reserve_entry_r':
				$this->SELECT_ITEM();
				$this->GET_KASOU_KUBUN();

				// === 死亡時刻 	
				//	$this->GET_SIBOU_TIME();


				$this->doReturn($objFormParam);

				break;
				//2014/12/16 ここまで				
			case 'reserve_entry':
			default:
				if (!empty($this->uke_no)) {
					$this->SELECT_ITEM();
					$this->GET_KASOU_KUBUN();

					// === 死亡時刻
					//$this->GET_SIBOU_TIME();

					$this->doDefault();
				} else {
					$this->response->sendRedirect('view_list.php');
				}
				break;
		}
	}

	// === 追記
	/**
	 * パラメーター情報の初期化
	 *
	 * @param  array $objFormParam フォームパラメータークラス
	 * @return void
	 */

	public function lfQueryYoyakuJokyo($conn, $sid, $gyosya_number, $ansyo_number, &$status, &$errcode, &$errmsg)
	{
		$ret = false;

		// 予約状況取得プロシジャーコール
		$stid = oci_parse($conn, 'begin QUERY_YOYAKUJOKYO(:p1, :p2, :p3, :p4, :p5, :p6); end;');
		oci_bind_by_name($stid, ':p1', $sid);
		oci_bind_by_name($stid, ':p2', $gyosya_number);
		oci_bind_by_name($stid, ':p3', $ansyo_number);
		oci_bind_by_name($stid, ':p4', $status, 4);
		oci_bind_by_name($stid, ':p5', $errcode, 8);
		oci_bind_by_name($stid, ':p6', $errmsg, 256);

		// クエリを実行します
		$r = oci_execute($stid);
		if (!$r) {
			$e = oci_error($stid);
			self::fnDispError(DB_ERROR, $e['message'] . ":::lfQueryYoyakuJokyo", true, DEBUG_MODE);
		}
		oci_free_statement($stid);

		if (intval($status) == 0) {
			$ret = true;
		} else {
			//エラー処理
			//Ut_Utils::printR($status);
			//Ut_Utils::printR($errcode);
			//Ut_Utils::printR($errmsg);
			$ret = false;
		}

		return $ret;
	}

	public function lfGetYoyakuTime($conn, $sid, $uke_nend, $uke_no, &$yoyaku_time)
	{
		$ret = false;

		$sql = "SELECT YOYAKU_TIME FROM YOYAKUJOKYOWK WHERE SID = :sid AND UKE_NEND = :uke_nend AND UKE_NO = :uke_no";
		$stid = oci_parse($conn, $sql);
		if (!$stid) {
			$e = oci_error($conn);
			self::fnDispError(DB_ERROR, $e['message'] . ":::lfGetYoyakuTime", true, DEBUG_MODE);
		}
		oci_bind_by_name($stid, ':sid', $sid);
		oci_bind_by_name($stid, ':uke_nend', $uke_nend);
		oci_bind_by_name($stid, ':uke_no', $uke_no);

		$r = oci_execute($stid);
		if (!$r) {
			$e = oci_error($stid);
			self::fnDispError(DB_ERROR, $e['message'] . ":::lfGetYoyakuTime_02", true, DEBUG_MODE);
		}

		$row = oci_fetch_row($stid);

		if ($row != false) {
			//Ut_Utils::printR($row);
			$ret = true;
			$yoyaku_time = $row[0];
		}

		oci_free_statement($stid);

		return $ret;
	}

	public function lfDoEntry($conn)
	{
		$ret = false;

		// 予約受付データ入力
		$sid = $this->session->getSid();
		$uke_nend = $this->session->getSession("UKE_NEND");
		$uke_no = $this->session->getSession("UKE_NO");
		// 入力パラメータ設定
		$params = $this->fnSetYoyakuDataParams($sid, $uke_nend, $uke_no, $this->arrForm);

		// === テスト出力
		//print_r($params);

		// $ret => 1 が返る
		$ret = $this->fnInsertYoyakuData($conn, $params);

		if ($ret == false) {
			$this->addError("予約受付データ入力ができませんでした。");
		} else {
			// デバッグ確認用
			$row = array();
			$r = $this->fnSelectYoyakuData($conn, $row);
		}
		//Ut_Utils::printR($ret);

		// 仮予約登録チェック
		$sid = $this->session->getSid();
		$gyosya_number = $this->session->getSession("gyosya_number");
		$ansyo_number = $this->session->getSession("ansyo_number");
		$uke_nend = $this->session->getSession("UKE_NEND");
		$uke_no = $this->session->getSession("UKE_NO");

		$status = NULL;
		$errcode = NULL;
		$errmsg = NULL;
		$ret = $this->fnYoyakuAllCheck($conn, $sid, $gyosya_number, $ansyo_number, $uke_nend, $uke_no, $status, $errcode, $errmsg);

		// Ut_Utils::printR($ret);

		if ($ret == false) {
			if (!empty($errmsg)) {
				//$this->addError($errmsg);
				$this->addError($errmsg);
			} else {
				$this->addError("仮予約登録チェックで問題がありました。");
			}
			// 予約受付データ入力エラー取得
			$sid = $this->session->getSid();
			$uke_nend = $this->session->getSession("UKE_NEND");
			$uke_no = $this->session->getSession("UKE_NO");
			$row = array();
			$ret = $this->fnSelectYoyakuDataErr($conn, $sid, $uke_nend, $uke_no, $row);


			if ($ret == false) {
				// bug fix No.17
				//$this->addError("予約受付データ入力エラー取得で問題がありました。");
			} else {


				$this->fnSetYoyakuDataErrParams($row, $this->arrErr);
			}
			// コミットNG
			$ret = false;
		} else {
			// コミットOK
			$ret = true;
		}
		//Ut_Utils::printR($ret);

		return $ret;
	}

	public function lfDoDelete($conn)
	{
		$ret = false;

		// 仮予約削除チェック
		$sid = $this->session->getSid();
		$gyosya_number = $this->session->getSession("gyosya_number");
		$ansyo_number = $this->session->getSession("ansyo_number");
		$uke_nend = $this->session->getSession("UKE_NEND");
		$uke_no = $this->session->getSession("UKE_NO");

		$status = NULL;
		$errcode = NULL;
		$errmsg = NULL;
		$ret = $this->fnYoyakuDelCheck($conn, $sid, $gyosya_number, $ansyo_number, $uke_nend, $uke_no, $status, $errcode, $errmsg);
		//Ut_Utils::printR($ret);
		if ($ret == false) {
			if (!empty($errmsg)) {
				$this->addError($errmsg);
			} else {
				$this->addError("仮予約削除チェックで問題がありました。");
			}
			// コミットNG
			$ret = false;
		} else {
			// コミットOK
			$ret = true;
		}
		//Ut_Utils::printR($ret);

		return $ret;
	}

	public function doConfirm(&$objFormParam)
	{
		$ret = false;

		if ($this->getMode() == 'entry_confirm') {
			$this->tpl_title = "新規登録";
		} else if ($this->getMode() == 'edit_confirm') {
			// edit時
			$this->tpl_title = "既存編集";
		} else {
			// delete時
			$this->tpl_title = "既存削除";
		}

		// パラメーター情報の初期化
		$this->fnInitParam($objFormParam);

		// 値の設定
		$objFormParam->setParam($_REQUEST);

		// 入力値の変換
		$objFormParam->convParam();


		// 値の取得
		$this->arrForm = $objFormParam->getHashArray();

		// 入力値エラーチェック
		$this->arrErr = $this->fnCheckError($objFormParam);

		if (empty($this->arrErr)) {
			// OCI
			$conn = oci_connect(DB_USER, DB_PASSWORD, DB_CONNECTION_STRING, DB_CHARSET);

			if (!$conn) {
				$e = oci_error();
				self::fnDispError(DB_ERROR, $e['message'] . ":::doConfirm", true, DEBUG_MODE);
			}

			// コミット判定
			$commitFlag = false;

			// 登録
			if ($this->getMode() == 'entry_confirm') {
				$commitFlag = $this->lfDoEntry($conn);
				// 変更
			} else if ($this->getMode() == 'edit_confirm') {
				$commitFlag = $this->lfDoEntry($conn);
				// 取消
			} else {
				$commitFlag = $this->lfDoDelete($conn);
			}

			// コミット判定
			if ($commitFlag == true) {
				oci_commit($conn);
			} else {
				oci_rollback($conn);
			}

			oci_close($conn);

			// bug fix No.18
			// セッションへフォーム内容を保存
			if (empty($this->tpl_error) && empty($this->arrErr)) {
				foreach ($this->arrForm as $key => $val) {
					$this->session->setSession($key, $val);
				}
				$ret = true;
			}
			//	Ut_Utils::printR($_SESSION);
		}

		return $ret;
	}

	public function doRead(&$objFormParam)
	{

		$ret = false;

		if ($this->getMode() == 'reserve_edit') {
			$this->tpl_title = "既存編集";
		} else {
			// cancel時
			$this->tpl_title = "既存取消";
		}


		// === 追加
		$kasou_type_g = $this->session->getSession("kasou_type");

		if ($kasou_type_g == 0) {
			$kasou_type_g = 0;
			$this->kasou_type = $kasou_type_g;
			//	print("if::火葬タイプ：12歳以上：" . $kasou_type . "<br />");
		} else if ($kasou_type_g == 1) {
			$kasou_type_g = 1;
			$this->kasou_type = $kasou_type_g;
			//	print("else if::火葬タイプ：12歳以下：" . $kasou_type . "<br />");
		} else if ($kasou_type_g == 2) {
			$kasou_type_g = 2;
			$this->kasou_type = $kasou_type_g;
			//	print("else::火葬タイプ：死産児：" . $kasou_type . "<br />");
		} else {
			$kasou_type_g = 11;
			$this->kasou_type = $kasou_type_g;
		}

		// OCI
		$conn = oci_connect(DB_USER, DB_PASSWORD, DB_CONNECTION_STRING, DB_CHARSET);

		if (!$conn) {
			$e = oci_error();
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		// 登録済みデータ取得
		$sid = $this->session->getSid();
		$gyosya_number = $this->session->getSession("gyosya_number");
		$ansyo_number = $this->session->getSession("ansyo_number");
		$uke_nend = $this->session->getSession("UKE_NEND");
		$uke_no = $this->session->getSession("UKE_NO");
		$status = NULL;
		$errcode = NULL;
		$errmsg = NULL;

		// === 
		$ret = $this->fnGetYoyakuData($conn, $sid, $gyosya_number, $ansyo_number, $uke_nend, $uke_no, $status, $errcode, $errmsg);
		// Ut_Utils::printR($ret);

		// print("ret:::" . $ret);

		if ($ret == false) {
			if (!empty($errmsg)) {
				$this->addError($errmsg);
			} else {
				$this->addError("登録済み予約データ取得で問題がありました。");
			}
			// bug fix No.18
			$this->dispDetailFlag = 0;
		} else {
			$row = array();
			$ret = $this->fnSelectYoyakuData($conn, $row);
			// === 追記　夏目
			$this->Arr_Yoyaku_Data = $row;
			//	Ut_Utils::printR($row);

			// print_r($row);

			if ($ret == true && !empty($row)) {
				$ret = true;
				$this->fnSetYoyakuDataFormParams($row, $this->arrForm);
			} else {
				$ret = false;
				$this->addError("登録済み予約データがありません。");
			}
		}

		// ======== 値取得 OK 確認済み 24_0215
		// Ut_Utils::printR($this->arrForm);

		oci_close($conn);

		return $ret;
	}

	public function doDefault()
	{
		$this->tpl_title = "新規登録";
	}

	//2014/12/16 ここから JIM 元川
	public function doReturn(&$objFormParam)
	{
		if ($this->getMode() == 'reserve_entry_r') {

			$this->tpl_title = "新規登録";
		} else if ($this->getMode() == 'reserve_edit_r') {
			// edit時
			$this->tpl_title = "既存編集";
		} else {
			// delete時
			$this->tpl_title = "既存削除";
		}

		// パラメーター情報の初期化
		$this->fnInitParam($objFormParam);

		// 値の設定
		$objFormParam->setParam($_SESSION);

		// 入力値の変換
		$objFormParam->convParam();

		// 値の取得
		$this->arrForm = $objFormParam->getHashArray();
	}

	//2014/12/16 ここまで

	/**
	 *  =========== 23_11_15 前橋用　追加　夏目
	 */
	public function SELECT_ITEM()
	{
		$waku_no  = $this->session->getSession("WAKU_NO");
		$this->waku_no_v = $waku_no;

		$shiki_type_v = $this->session->getSession("shiki_type");
		$this->shiki_type_vv = $shiki_type_v;

		// OCI
		$conn = oci_connect(DB_USER, DB_PASSWORD, DB_CONNECTION_STRING, DB_CHARSET);

		if (!$conn) {
			$e = oci_error();
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		$sql = "SELECT 寺院コード, 寺院名称 FROM 寺院 order by 寺院コード ASC";
		$stid = oci_parse($conn, $sql);
		if (!$stid) {
			$e = oci_error($conn);
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		$r = oci_execute($stid);
		if (!$r) {
			$e = oci_error($stid);
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		$nrows = oci_fetch_all($stid, $Zint_row, null, null, OCI_FETCHSTATEMENT_BY_ROW);


		$this->arrZiin_val = array();

		$idx = 1;
		foreach ($Zint_row as $ziin_val) {

			$ziin_idx = $ziin_val['寺院名称'];
			$this->arrZiin_val[$ziin_idx] = $ziin_val['寺院名称'];
		}

		// print_r($this->arrZiin_val);


		if (
			$nrows > 0
		) {
			//Ut_Utils::printR($res);
			$this->arrZiin_val_v = $this->arrZiin_val;
		}

		oci_free_statement($stid);

		// OCI
		$conn = oci_connect(DB_USER, DB_PASSWORD, DB_CONNECTION_STRING, DB_CHARSET);

		if (!$conn) {
			$e = oci_error();
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		$sql = "SELECT 形態区分, 宗派名 FROM 葬儀形態 order by 形態区分 ASC";
		$stid = oci_parse($conn, $sql);
		if (!$stid) {
			$e = oci_error($conn);
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		$r = oci_execute($stid);
		if (!$r) {
			$e = oci_error($stid);
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		$nrows = oci_fetch_all($stid, $Syuu_row, null, null, OCI_FETCHSTATEMENT_BY_ROW);

		$arrSyuu_k_Val = array();

		$idx = 1;
		foreach ($Syuu_row as $Syuu_k_Val) {
			//	$key_idx = $Syuu_k_Val['形態区分'];
			$key_idx = $Syuu_k_Val['形態区分'];
			$arrSyuu_k_Val[$key_idx] = $Syuu_k_Val['宗派名'];
			//	$idx += 1;
		}

		if (
			$nrows > 0
		) {
			//Ut_Utils::printR($res);
			$this->arrSyuu_k_Val_v = $arrSyuu_k_Val;
		}

		oci_free_statement($stid);


		$conn = oci_connect(DB_USER, DB_PASSWORD, DB_CONNECTION_STRING, DB_CHARSET);

		if (!$conn) {
			$e = oci_error();
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		$sql = "SELECT 出棺場所コード, 出棺場所名 FROM 出棺場所 order by 出棺場所コード asc";
		$stid = oci_parse($conn, $sql);
		if (!$stid) {
			$e = oci_error($conn);
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		$r = oci_execute($stid);
		if (!$r) {
			$e = oci_error($stid);
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		$nrows = oci_fetch_all($stid, $Syukan_row, null, null, OCI_FETCHSTATEMENT_BY_ROW);

		$this->arrSyukan_Place = array();

		$idx = 1;
		foreach ($Syukan_row as $Syukan_Place_val) {
			//	$key_idx = $Syukan_Place_val['出棺場所コード'];
			$key_idx = $Syukan_Place_val['出棺場所名'];
			$this->arrSyukan_Place[$key_idx] = $Syukan_Place_val['出棺場所名'];
			//	$idx += 1;
		}

		// print_r($this->arrSyukan_Place);

		if (
			$nrows > 0
		) {
			//Ut_Utils::printR($res);
			$this->arrSyukan_Place_v = $this->arrSyukan_Place;
		}

		oci_free_statement($stid);
		oci_close($conn);


		// ==================================================================================
		//========================　死産児 （妊娠週数　・　妊娠月数） ==========================
		// ==================================================================================

		$arr_Nin_Week = array(); // === 週
		$arr_Nin_Month = array(); // === 月
		$loop_num_W = 4;
		$loop_num_M = 12;

		$idx = 0;
		for ($i = 0; $i <= $loop_num_W; $i++) {
			$arr_Nin_Week[$idx] = $i;
			$idx += 1;
		}
		$this->arr_Nin_Week_V = $arr_Nin_Week;

		for ($i = 0; $i <= $loop_num_M; $i++) {
			$arr_Nin_Month[$idx] = $i;
			$idx += 1;
		}
		$this->arr_Nin_Month_V = $arr_Nin_Month;
	}

	/**
	 *   火葬区分　取得　（前橋用）
	 */
	// ============================= 追加 23_1130 夏目
	function GET_KASOU_KUBUN()
	{

		// OCI
		$conn = oci_connect(DB_USER, DB_PASSWORD, DB_CONNECTION_STRING, DB_CHARSET);

		if (!$conn) {
			$e = oci_error();
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		$sql = "SELECT 火葬区分, 区分名 FROM 火葬区分 WHERE 火葬区分 < 3";
		$stid = oci_parse($conn, $sql);
		if (!$stid) {
			$e = oci_error($conn);
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		$r = oci_execute($stid);
		if (!$r) {
			$e = oci_error($stid);
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		$nrows = oci_fetch_all($stid, $res, null, null, OCI_FETCHSTATEMENT_BY_ROW);

		$arr_Kasou_k = array();
		$arr_Kasou_k_Name = array();

		$idx = 0;
		foreach ($res as $k_val) {
			$arr_Kasou_k[$idx] = $k_val['火葬区分'];
			$arr_Kasou_k_Name[$idx] = $k_val['区分名'];
			$idx += 1;
		}

		// === 火葬区分  ( [0] => 大人(12歳以上) [1] => 小人(12歳未満) [2] => 死産児 )
		// print_r($arr_Kasou_k_Name);

		if (
			$nrows > 0
		) {
			//Ut_Utils::printR($res);
			$this->arrKsou_K = $arr_Kasou_k_Name;
		}

		oci_free_statement($stid);
		oci_close($conn);

		$kasou_type_g = $this->session->getSession("kasou_type");

		// print($kasou_type_g . ":::kasou_type_g");

		if ($kasou_type_g == 0) {
			$kasou_type_g = 0;
			$this->kasou_type = $kasou_type_g;
			//	print("if::火葬タイプ：12歳以上：" . $kasou_type . "<br />");
		} else if ($kasou_type_g == 1) {
			$kasou_type_g = 1;
			$this->kasou_type = $kasou_type_g;
			//	print("else if::火葬タイプ：12歳以下：" . $kasou_type . "<br />");
		} else if ($kasou_type_g == 2) {
			$kasou_type_g = 2;
			$this->kasou_type = $kasou_type_g;
			//	print("else::火葬タイプ：死産児：" . $kasou_type . "<br />");
		} else {
			$kasou_type_g = 11;
			$this->kasou_type = $kasou_type_g;
		}
	}
	// ============================= 追加 23_1130 夏目 

	/**
	 *  死亡時刻取得
	 */
	function GET_SIBOU_TIME()
	{

		$sibou_time_Flg = "";

		$uke_nend = $this->session->getSession("UKE_NEND");

		$waku_no  = $this->session->getSession("WAKU_NO");
		$uke_no = $this->session->getSession("UKE_NO");

		// print($uke_no);

		// OCI
		$conn = oci_connect(DB_USER, DB_PASSWORD, DB_CONNECTION_STRING, DB_CHARSET);

		if (!$conn) {
			$e = oci_error();
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		//	$sql = "SELECT 死亡時刻 FROM 火葬受付 WHERE 受付番号 = :uke_no";
		$sql = "SELECT 死亡時刻 FROM 火葬受付 WHERE 受付番号 = :uke_no AND 死亡時刻 IS NOT NULL";

		$stid = oci_parse($conn, $sql);
		if (!$stid) {
			$e = oci_error($conn);
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		oci_bind_by_name($stid, ":uke_no", $uke_no);

		$r = oci_execute($stid);
		if (!$r) {
			$e = oci_error($stid);
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		$nrows = oci_fetch_all($stid, $r_get, null, null, OCI_FETCHSTATEMENT_BY_ROW);

		if ($nrows > 0) {
			//Ut_Utils::printR($res);
			// Ut_Utils::printR($nrows);
			$ret = true;
		}

		if (isset($r_get[0])) {

			$GET_sibou_time = $r_get[0]['死亡時刻'];

			//print($GET_sibou_time . "\n");

			$this->GET_sibou_time_V = $GET_sibou_time;

			$length = strlen($GET_sibou_time);

			$first_part = "";
			$second_part = "";

			if ($length == 1) {

				$second_part = substr($GET_sibou_time, 0, 1);
				$sibou_time_Flg = 3;
				$first_part = 0;

				$this->sibou_time_Flg_v = $sibou_time_Flg;

				$this->death_first_time = $first_part;
				$this->death_second_time = $second_part;
			} elseif ($length == 2) {

				$second_part = substr($GET_sibou_time, 0, 2);
				$sibou_time_Flg = 2;
				$first_part = 0;

				$this->sibou_time_Flg_v = $sibou_time_Flg;

				$this->death_first_time = $first_part;
				$this->death_second_time = $second_part;
			} elseif ($length == 3) {
				$first_part = substr($GET_sibou_time, 0, 1);
				$second_part = substr($GET_sibou_time, -2, 2);

				$sibou_time_Flg = 1;

				$this->sibou_time_Flg_v = $sibou_time_Flg;
				$this->death_first_time = $first_part;
				$this->death_second_time = $second_part;

				/*
				print($first_part . "\n");
				print($second_part . "\n");
				*/
			} elseif ($length == 4) {
				$first_part = substr($GET_sibou_time, 0, 2);
				$second_part = substr($GET_sibou_time, -2, 2);

				$sibou_time_Flg = 1;

				$this->sibou_time_Flg_v = $sibou_time_Flg;
				$this->death_first_time = $first_part;
				$this->death_second_time = $second_part;

				/*
				print($first_part . "\n");
				print($second_part . "\n");
				*/
			}
		} else {

			$sibou_time_Flg = "";
			$this->sibou_time_Flg_v = $sibou_time_Flg;
		}

		oci_free_statement($stid);
		oci_close($conn);
	}



	function GET_YOUSIKI()
	{

		$Yousiki_Flg = "";

		$uke_nend = $this->session->getSession("UKE_NEND");

		$waku_no  = $this->session->getSession("WAKU_NO");
		$uke_no = $this->session->getSession("UKE_NO");

		// print($uke_no);

		// OCI
		$conn = oci_connect(DB_USER, DB_PASSWORD, DB_CONNECTION_STRING, DB_CHARSET);

		if (!$conn) {
			$e = oci_error();
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		//	$sql = "SELECT 死亡時刻 FROM 火葬受付 WHERE 受付番号 = :uke_no";
		$sql = "SELECT 葬儀形態区分 FROM 火葬受付 WHERE 受付年度 = :uke_nend AND 受付番号 = :uke_no AND 葬儀形態区分 IS NOT NULL";

		$stid = oci_parse($conn, $sql);
		if (!$stid) {
			$e = oci_error($conn);
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		oci_bind_by_name($stid, ":uke_no", $uke_no);
		oci_bind_by_name($stid, ":uke_nend", $uke_nend);

		$r = oci_execute($stid);
		if (!$r) {
			$e = oci_error($stid);
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		$nrows = oci_fetch_all($stid, $yousiki_get, null, null, OCI_FETCHSTATEMENT_BY_ROW);

		if ($nrows > 0) {
			//Ut_Utils::printR($res);
			// Ut_Utils::printR($nrows);
			$ret = true;
		}

		if (isset($yousiki_get[0])) {

			$GET_yousiki = $yousiki_get[0]['葬儀形態区分'];

			// print($GET_yousiki . "\n");

			$Yousiki_Flg = 1;


			$this->Yousiki_Flg_v = $Yousiki_Flg;

			$this->GET_yousiki_v = $GET_yousiki;
		} else {

			$Yousiki_Flg = "";
			$this->Yousiki_Flg_v = $Yousiki_Flg;
		}

		oci_free_statement($stid);
		oci_close($conn);
	}


	function GET_ZIIN()
	{

		$Ziin_Flg = "";
		$Ziin_Flg_Text = "";

		$uke_nend = $this->session->getSession("UKE_NEND");

		$waku_no  = $this->session->getSession("WAKU_NO");
		$uke_no = $this->session->getSession("UKE_NO");

		// print($uke_no);

		// OCI
		$conn = oci_connect(DB_USER, DB_PASSWORD, DB_CONNECTION_STRING, DB_CHARSET);

		if (!$conn) {
			$e = oci_error();
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		//	$sql = "SELECT 死亡時刻 FROM 火葬受付 WHERE 受付番号 = :uke_no";
		$sql = "SELECT 寺院名称 FROM 火葬受付 WHERE 受付年度 = :uke_nend AND 受付番号 = :uke_no AND 寺院名称 IS NOT NULL";

		$stid = oci_parse($conn, $sql);
		if (!$stid) {
			$e = oci_error($conn);
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		oci_bind_by_name($stid, ":uke_no", $uke_no);
		oci_bind_by_name($stid, ":uke_nend", $uke_nend);

		$r = oci_execute($stid);
		if (!$r) {
			$e = oci_error($stid);
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		$nrows = oci_fetch_all($stid, $ziin_get, null, null, OCI_FETCHSTATEMENT_BY_ROW);

		if ($nrows > 0) {
			//Ut_Utils::printR($res);
			// Ut_Utils::printR($nrows);
			$ret = true;
		}

		if (isset($ziin_get[0])) {

			$GET_ziin = $ziin_get[0]['寺院名称'];

			if (in_array($GET_ziin, $this->arrZiin_val)) {

				$Ziin_Flg_Text = "";
				$Ziin_Flg = 1;

				$this->Ziin_Flg_Text_v = $Ziin_Flg_Text;
				$this->Ziin_Flg_v = $Ziin_Flg;
				$this->GET_ziin_v = $GET_ziin;
			} else {

				$Ziin_Flg = "";
				$Ziin_Flg_Text = 1;

				$this->Ziin_Flg_Text_v = $Ziin_Flg_Text;
				$this->Ziin_Flg_v = $Ziin_Flg;
				$this->GET_ziin_v = $GET_ziin;
			}
		} else {

			$Ziin_Flg = "";
			$this->Ziin_Flg_v = $Ziin_Flg;
		}

		oci_free_statement($stid);
		oci_close($conn);
	}


	function GET_SYUKAN()
	{

		$Syukann_Flg = "";
		$Syukann_Flg_Text = "";

		$uke_nend = $this->session->getSession("UKE_NEND");

		$waku_no  = $this->session->getSession("WAKU_NO");
		$uke_no = $this->session->getSession("UKE_NO");

		// print($uke_no);

		// OCI
		$conn = oci_connect(DB_USER, DB_PASSWORD, DB_CONNECTION_STRING, DB_CHARSET);

		if (!$conn) {
			$e = oci_error();
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		//	$sql = "SELECT 死亡時刻 FROM 火葬受付 WHERE 受付番号 = :uke_no";
		$sql = "SELECT 出棺場所名 FROM 火葬受付 WHERE 受付年度 = :uke_nend AND 受付番号 = :uke_no AND 出棺場所名 IS NOT NULL";

		$stid = oci_parse($conn, $sql);
		if (!$stid) {
			$e = oci_error($conn);
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		oci_bind_by_name($stid, ":uke_no", $uke_no);
		oci_bind_by_name($stid, ":uke_nend", $uke_nend);

		$r = oci_execute($stid);
		if (!$r) {
			$e = oci_error($stid);
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		$nrows = oci_fetch_all($stid, $syukann_get, null, null, OCI_FETCHSTATEMENT_BY_ROW);

		if ($nrows > 0) {
			//Ut_Utils::printR($res);
			// Ut_Utils::printR($nrows);
			$ret = true;
		}

		if (isset($syukann_get[0])) {

			if (!empty($syukann_get[0])) {

				$GET_syukann = $syukann_get[0]['出棺場所名'];

				//	print($GET_syukann);
				if (in_array($GET_syukann, $this->arrSyukan_Place)) {

					$Syukann_Flg = 1;
					$Syukann_Flg_Text = "";

					$this->Syukann_Flg_Text_v = $Syukann_Flg_Text;
					$this->Syukann_Flg_v = $Syukann_Flg;
					$this->GET_syukann_v = $GET_syukann;
				} else {

					$Syukann_Flg = "";
					$Syukann_Flg_Text = 1;

					$this->Syukann_Flg_Text_v = $Syukann_Flg_Text;
					$this->Syukann_Flg_v = $Syukann_Flg;
					$this->GET_syukann_v = $GET_syukann;
				}
			}
		} else {

			$Syukann_Flg = "";
			$this->Syukann_Flg_v = $Syukann_Flg;
		}

		oci_free_statement($stid);
		oci_close($conn);
	}


	/**
	 *   
	 */
	function GET_KOZIN_ZOKU()
	{

		$KOZIN_ZOKU_Flg = "";
		$KOZIN_ZOKU_Flg_Text = "";

		$uke_nend = $this->session->getSession("UKE_NEND");

		$waku_no  = $this->session->getSession("WAKU_NO");
		$uke_no = $this->session->getSession("UKE_NO");

		// print($uke_no);

		// OCI
		$conn = oci_connect(DB_USER, DB_PASSWORD, DB_CONNECTION_STRING, DB_CHARSET);

		if (!$conn) {
			$e = oci_error();
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		//	$sql = "SELECT 死亡時刻 FROM 火葬受付 WHERE 受付番号 = :uke_no";
		$sql = "SELECT 申請者続柄 FROM 火葬受付 WHERE 受付年度 = :uke_nend AND 受付番号 = :uke_no AND 申請者続柄 IS NOT NULL";

		$stid = oci_parse($conn, $sql);
		if (!$stid) {
			$e = oci_error($conn);
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		oci_bind_by_name($stid, ":uke_no", $uke_no);
		oci_bind_by_name($stid, ":uke_nend", $uke_nend);

		$r = oci_execute($stid);
		if (!$r) {
			$e = oci_error($stid);
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		$nrows = oci_fetch_all($stid, $kozin_zoku_get, null, null, OCI_FETCHSTATEMENT_BY_ROW);

		if ($nrows > 0) {
			//Ut_Utils::printR($res);
			// Ut_Utils::printR($nrows);
			$ret = true;
		}

		if (isset($kozin_zoku_get[0])) {

			if (!empty($kozin_zoku_get[0])) {

				$GET_kozin_zoku_get = $kozin_zoku_get[0]['申請者続柄'];

				if ($GET_kozin_zoku_get === '親族') {
					// echo "0（親族）";
					// print($GET_kozin_zoku_get);

					$KOZIN_ZOKU_Flg = "";
					$KOZIN_ZOKU_Flg_Text = "";

					$this->KOZIN_ZOKU_Flg_Text_v = $KOZIN_ZOKU_Flg_Text;
					$this->KOZIN_ZOKU_Flg_v = $KOZIN_ZOKU_Flg;
					$this->GET_kozin_zoku_v = $GET_kozin_zoku_get;
				} else {
					// echo "1（その他）";
					// print($GET_kozin_zoku_get);

					$KOZIN_ZOKU_Flg = 1;
					$KOZIN_ZOKU_Flg_Text = 1;

					$this->KOZIN_ZOKU_Flg_Text_v = $KOZIN_ZOKU_Flg_Text;
					$this->KOZIN_ZOKU_Flg_v = $KOZIN_ZOKU_Flg;
					$this->GET_kozin_zoku_v = $GET_kozin_zoku_get;
				}
			} else {

				$KOZIN_ZOKU_Flg = "";
				$this->KOZIN_ZOKU_Flg_v = $KOZIN_ZOKU_Flg;
			}

			oci_free_statement($stid);
			oci_close($conn);
		}
	}



	/**
	 *   　死亡場所　セット
	 */
	function SIBOU_PLACE()
	{

		$SIBOU_PLACE_Flg = "";

		$uke_nend = $this->session->getSession("UKE_NEND");
		$waku_no  = $this->session->getSession("WAKU_NO");
		$uke_no = $this->session->getSession("UKE_NO");

		// OCI
		$conn = oci_connect(DB_USER, DB_PASSWORD, DB_CONNECTION_STRING, DB_CHARSET);

		if (!$conn) {
			$e = oci_error();
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		//	$sql = "SELECT 申請者続柄 FROM 火葬受付 WHERE 受付年度 = :uke_nend AND 受付番号 = :uke_no AND 申請者続柄 IS NOT NULL";
		$sql = "SELECT 死亡場所 FROM 火葬受付 WHERE 受付年度 = :uke_nend AND 受付番号 = :uke_no AND 死亡場所 IS NOT NULL";

		$stid = oci_parse($conn, $sql);
		if (!$stid) {
			$e = oci_error($conn);
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		oci_bind_by_name($stid, ":uke_no", $uke_no);
		oci_bind_by_name($stid, ":uke_nend", $uke_nend);

		$r = oci_execute($stid);
		if (!$r) {
			$e = oci_error($stid);
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		$nrows = oci_fetch_all($stid, $sibou_place_get, null, null, OCI_FETCHSTATEMENT_BY_ROW);

		if ($nrows > 0) {
			//Ut_Utils::printR($res);
			// Ut_Utils::printR($nrows);
			$ret = true;
		}

		if (isset($sibou_place_get[0])) {

			if (!empty($sibou_place_get[0])) {
				// === テキストボックスが入力ありのとき
				$SIBOU_PLACE_Flg = 1;
				$GET_sibou_place_get = $sibou_place_get[0]['死亡場所'];

				// print($GET_sibou_place_get);

				$this->SIBOU_PLACE_Flg_v = $SIBOU_PLACE_Flg;
				$this->GET_sibou_place_get_v = $GET_sibou_place_get;
			}
		} else {
			// === テキストボックスが空欄時の処理
			$SIBOU_PLACE_Flg = "";
			$GET_sibou_place_get = "";

			$this->SIBOU_PLACE_Flg_v = $SIBOU_PLACE_Flg;
			$this->GET_sibou_place_get_v = $GET_sibou_place_get;
		}

		oci_free_statement($stid);
		oci_close($conn);
	}


	/*
	DB項目なし　「連絡事項」へ挿入する値の処理の、「修正」時の対応
	*/
	function GET_RENRAKU_ZIKOU()
	{

		$Ren_ZIKOU_Flg = "";
		$Ren_ZIKOU_Flg_Text = "";

		$uke_nend = $this->session->getSession("UKE_NEND");

		$waku_no  = $this->session->getSession("WAKU_NO");
		$uke_no = $this->session->getSession("UKE_NO");

		// print($uke_no);

		// OCI
		$conn = oci_connect(DB_USER, DB_PASSWORD, DB_CONNECTION_STRING, DB_CHARSET);

		if (!$conn) {
			$e = oci_error();
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		//	$sql = "SELECT 死亡時刻 FROM 火葬受付 WHERE 受付番号 = :uke_no";
		$sql = "SELECT 連絡事項 FROM 火葬受付 WHERE 受付年度 = :uke_nend AND 受付番号 = :uke_no AND 連絡事項 IS NOT NULL";

		$stid = oci_parse($conn, $sql);
		if (!$stid) {
			$e = oci_error($conn);
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		oci_bind_by_name($stid, ":uke_no", $uke_no);
		oci_bind_by_name($stid, ":uke_nend", $uke_nend);

		$r = oci_execute($stid);
		if (!$r) {
			$e = oci_error($stid);
			self::fnDispError(DB_ERROR, $e['message'], true, DEBUG_MODE);
		}

		$nrows = oci_fetch_all($stid, $Renraku_Val_get, null, null, OCI_FETCHSTATEMENT_BY_ROW);

		// var_dump($Renraku_Val_get);
		// print_r($Renraku_Val_get);

		if ($nrows > 0) {
			//Ut_Utils::printR($res);
			// Ut_Utils::printR($nrows);
			$ret = true;
		}


		if (isset($Renraku_Val_get[0])) {

			if (!empty($Renraku_Val_get[0])) {

				$GET_Renraku_Val = $Renraku_Val_get[0]['連絡事項'];
				//	print($GET_Renraku_Val);

				// === 値を分割 1
				$GET_arr = explode("\n", $GET_Renraku_Val);

				$Ren_Mosyu = "";		// 喪主:
				$Ren_Weight = "";		// 体重:
				$Ren_Reian = "";		// 霊安室利用:
				$Ren_Kouro = "";		// 香炉:
				$Ren_room = "";			// 部屋の大きさ
				$Ren_Machiai_roby = ""; // ロビー待合せ:
				$Ren_Machiai_riyou = "";	//利用者:
				$Ren_Youshiki = "";	//様式:

				$Patterns = array(
					"喪主:",
					"体重:",
					"霊安室利用:",
					"香炉:",
					"部屋の大きさ:",
					"ロビー待合せ:",
					"利用者:",
					"様式:",
				);

				foreach ($GET_arr as $Ren_Val) {

					if (strpos($Ren_Val, $Patterns[0]) !== false) {
						$Ren_Mosyu = $Ren_Val;
						//	print("【喪主】" . $Ren_Mosyu);
					}

					if (strpos($Ren_Val, $Patterns[1]) !== false) {
						$Ren_Weight = $Ren_Val;
						//	print("【体重】" . $Ren_Weight);
					}

					if (strpos($Ren_Val, $Patterns[2]) !== false) {
						$Ren_Reian = $Ren_Val;
						print("【霊安室利用】" . $Ren_Reian);
					}

					if (strpos($Ren_Val, $Patterns[3]) !== false) {
						$Ren_Kouro = $Ren_Val;
						print("【香炉】" . $Ren_Kouro);
					}

					if (strpos($Ren_Val, $Patterns[4]) !== false) {
						$Ren_room = $Ren_Val;
						print("【部屋の大きさ】" . $Ren_room);
					}

					if (strpos($Ren_Val, $Patterns[5]) !== false) {
						$Ren_Machiai_roby = $Ren_Val;
						print("【ロビー待合せ】" . $Ren_Machiai_roby);
					}

					if (strpos($Ren_Val, $Patterns[6]) !== false) {
						$Ren_Machiai_riyou = $Ren_Val;
						print("【利用者】" . $Ren_Machiai_riyou);
					}

					if (strpos($Ren_Val, $Patterns[7]) !== false) {
						$Ren_Youshiki = $Ren_Val;
						print("【様式】" . $Ren_Youshiki);
					}
				}
			} else {

				// === 連絡事項が　空の時の処理
				$Ren_ZIKOU_Flg = "";
				print("値なし（連絡事項）");
			}

			oci_free_statement($stid);
			oci_close($conn);
		}
	}

	/**
	 *  パターンマッチ（連絡事項）　用  前橋用　夏目 
	 */
	public function RenVal_CUT($Pattern, $val)
	{

		if (preg_match($Pattern, $val)) {
			$val = $Pattern;
			return $val;
		} else {
			$val = "";
			return $val;
		}
	}
}



$objPage = new Reserve_Edit();
$objPage->init();
$objPage->process();
