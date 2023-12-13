<?php  

//============ スマーティー用　php oracle
 
/**
	 *  =========== 23_11_15 前橋用　追加　夏目
	 */
	public function SELECT_ITEM()
	{
		$waku_no  = $this->session->getSession("WAKU_NO");
		$this->waku_no_v = $waku_no;

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


		$arrZiin_val = array();

		$idx = 1;
		foreach ($Zint_row as $ziin_val) {
			$ziin_idx = $ziin_val['寺院コード'];
			$arrZiin_val[$ziin_idx] = $ziin_val['寺院名称'];
			//	$arrZiin_val[$idx] = $ziin_val['寺院名称'];
			//	$idx += 1;
		}


		if (
			$nrows > 0
		) {
			//Ut_Utils::printR($res);
			$this->arrZiin_val_v = $arrZiin_val;
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

		$arrSyukan_Place = array();

		$idx = 1;
		foreach ($Syukan_row as $Syukan_Place_val) {
			$key_idx = $Syukan_Place_val['出棺場所コード'];
			$arrSyukan_Place[$key_idx] = $Syukan_Place_val['出棺場所名'];
			//	$idx += 1;
		}

		if (
			$nrows > 0
		) {
			//Ut_Utils::printR($res);
			$this->arrSyukan_Place_v = $arrSyukan_Place;
		}

		oci_free_statement($stid);
		oci_close($conn);
	}

?>