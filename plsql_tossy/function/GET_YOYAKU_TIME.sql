CREATE OR REPLACE FUNCTION GET_WAKUNUM_YOYAKUTIME(
    P_DATE DATE, --- 予約日
    P_YWAKU NUMBER --- 枠番号
) RETURN NUMBER -- 戻り値のデータ型

 /*******************************************************************************
  MODULE    GET_RKS_YOYAKUBI
  概要       予約枠から、最新の適用日で、時間に変換
  説明      ：
  引数      ：変数名      属性          I/O  項目名
  戻り値                  DATE           O   予約可能開始日
  更新履歴    更新日      担当者        内容
  00.00.00    2023/11/28  JIM 夏目      新規
*******************************************************************************/
 IS
BEGIN
 /*******************************************************************************
  宣言部
*******************************************************************************/
    DECLARE
        V_YWAKU_TIME NUMBER; --- 戻り値用
        CURSOR C_WK1 IS
 ----- 予約日からの、最新の適用開始日のデータを取得（日付のところには、予約日が入る） 修正 02
        SELECT
            予約枠.適用開始日,
            予約枠.KEY2,
            予約枠名称.予約枠時刻
        FROM
            予約枠,
            予約枠名称
        WHERE
            予約枠.適用開始日 = (
                SELECT
                    MAX(適用開始日)
                FROM
                    予約枠
                WHERE
                    適用開始日 <= TO_DATE(P_DATE, 'YYYY-mm-dd')
            )
            AND 予約枠.KEY2 = 予約枠名称.KEY2
            AND 予約枠.KEY3 = 0
            AND 予約枠.適用開始日 = 予約枠名称.適用開始日;
        R_WK1        C_WK1%ROWTYPE;
 /*======================================
  本体
======================================*/
    BEGIN
 --- 初期処理
        V_YWAKU_TIME := 0;
        IF P_YWAKU IS NOT NULL THEN
            FOR R_WK1 IN C_WK1 LOOP
                IF R_RK1.KEY2 = P_YWAKU THEN
                    V_YWAKU_TIME := R_WK1.予約枠時刻; --- 時刻を入れる
                    RETURN V_YWAKU_TIME;
                ELSE
                    V_YWAKU_TIME := 0; --- 時刻なし
                    RETURN V_YWAKU_TIME;
                END IF;
            END LOOP;
        END IF;
 /*******************************************************************************
  例外処理部
*******************************************************************************/
    EXCEPTION
        WHEN OTHERS THEN
            RETURN -1;
    END;
END;