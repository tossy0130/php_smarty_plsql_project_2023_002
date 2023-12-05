CREATE OR REPLACE FUNCTION GET_WAKUNUM_YOYAKUTIME(
    P_DATE IN DATE, --- 予約日
    P_YWAKU IN NUMBER --- 枠番号
) RETURN NUMBER -- 戻り値のデータ型

 /*******************************************************************************
  MODULE    GET_RKS_YOYAKUBI
  概要       予約枠から、最新の適用日で、時間に変換。
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
        V_DATE       DATE;
        CURSOR C_WK1 IS
        SELECT
            YYW.KEY2,
            YWM.予約枠時刻
        FROM
            予約枠   YYW,
            予約枠名称 YWM
        WHERE
            YYW.適用開始日 = (
                SELECT
                    MAX(適用開始日)
                FROM
                    予約枠
                WHERE
 --  適用開始日 <= TO_DATE(p_DATE, 'YYYY-MM-DD')
                    適用開始日 < V_DATE
            )
            AND YYW.KEY2 = YWM.KEY2
            AND YYW.KEY3 = 0
            AND YYW.適用開始日 = YWM.適用開始日;
 --- レコード
        R_WK1        C_WK1%ROWTYPE;
 /*======================================
  本体
======================================*/
    BEGIN
 --- 初期処理
        V_YWAKU_TIME := 0;
 --- 日付処理
        IF P_DATE IS NULL THEN
            V_DATE := SYSDATE;
        ELSE
            V_DATE := P_DATE;
        END IF;

        IF P_YWAKU IS NOT NULL THEN
 --    OPEN c_WK1;
 --    FETCH c_WK1 INTO r_WK1;
            FOR R_WK1 IN C_WK1 LOOP
                IF R_WK1.KEY2 = P_YWAKU THEN
                    V_YWAKU_TIME := R_WK1.予約枠時刻; --- 時刻を入れる
 --  DBMS_OUTPUT.PUT_LINE(v_YWAKU_TIME);
                    EXIT;
                END IF;
            END LOOP;

            RETURN V_YWAKU_TIME;
        END IF;

        CLOSE C_WK1; --- カーソルをCLOSE

 /*******************************************************************************
  例外処理部
*******************************************************************************/
    EXCEPTION
        WHEN OTHERS THEN
            RETURN -1;
    END;
END;