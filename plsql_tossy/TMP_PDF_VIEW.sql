CREATE OR REPLACE PROCEDURE TMP_PDF_VIEWPRO (
    P_SID IN VARCHAR2, --セッションID
    P_GYOCD IN NUMBER, --業者コード
    P_YOYAKUBI IN DATE, --- 予約日付
    P_RSLT OUT NUMBER, --ステータス(0:正常終了　99:エラー)
    P_SQLCODE OUT NUMBER, --エラーコード
    P_SQLERRM OUT VARCHAR2 --エラーメッセージ
)
 /*******************************************************************************
* 関数名 : TMP_PDF_VIEW
* 作成者 : 夏目
* 作成日 : 2024/01/04
* 概要   : Web予約 PDF アップロード情報出力
* 機能   : PDF（埋火葬許可書）がアップロードされた情報を表示
* 履歴   : 2024/01/04    夏目      新規
*          
*******************************************************************************/
 /*======================================
  変数宣言
======================================*/ IS
    CURSOR C_WK1 IS
    SELECT
        PDF_T.業者コード,
        PDF_T.業者名,
        PDF_T.受付年度,
        PDF_T.受付番号,
        PDF_T.予約日付,
        PDF_T.死亡者姓,
        PDF_T.死亡者名,
        PDF_T.ファイル名,
        PDF_T.ファイルパス
    FROM
        PDF_UPDETA PDF_T
    WHERE
        PDF_T.予約日付 >= TO_DATE(TO_CHAR(P_YOYAKUBI, 'YYYY-MM-DD'), 'YYYY-MM-DD')
        AND PDF_T.業者コード = P_GYOCD;
 --- レコードの宣言
    R_WK1 C_WK1%ROWTYPE;
 /*======================================
  本体
======================================*/
BEGIN
 --- 初期処理
    P_RSLT := 0;
    P_SQLCODE := 0;
    P_SQLERRM := NULL;
 --- テンプテーブル　クリア
    DELETE FROM TMP_PDF_VIEW
    WHERE
        SID = P_SID;
 --- 業者コードが NULLじゃなかった場合
    IF P_GYOCD IS NOT NULL THEN
        FOR R_WK1 IN C_WK1 LOOP
            INSERT INTO TMP_PDF_VIEW(
                SID, --- セッションIS
                GYOUSYA_CD, --- 業者コード
                GYOUSA_MEI, --- 業者名
                UKETUKE_NENDO, --- 受付年度
                UKETUKE_NUM, --- 受付番号
                YOYAKU_DATE, --- 予約日付
                SIBOUSHA_SEI, --- 死亡者姓
                SIBOUSHA_MEI, --- 死亡者名
                PDF_FILENAME, --- PDFファイル名
                PDF_FILEPATH
            ) VALUES (
                P_SID,
                R_WK1.業者コード,
                R_WK1.業者名,
                R_WK1.受付年度,
                R_WK1.受付番号,
                R_WK1.予約日付,
                R_WK1.死亡者姓,
                R_WK1.死亡者名,
                R_WK1.ファイル名,
                R_WK1.ファイルパス
            );
        END LOOP;
    END IF;
 /*======================================
 例外処理
======================================*/
EXCEPTION
    WHEN OTHERS THEN
        P_RSLT := 99;
        P_SQLCODE := SQLCODE;
        P_SQLERRM := SQLERRM;
END;