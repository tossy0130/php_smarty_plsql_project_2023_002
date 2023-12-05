CREATE OR REPLACE FUNCTION GET_RKS_YOYAKUBI RETURN DATE -- 戻り値のデータ型

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
        V_DEFSWKB NUMBER; -- デフォルト切替区分 -1:前日 0:当日
        V_DEFSWTM NUMBER; -- デフォルト切替時間
        V_SYSDATE DATE;
 --初期設定情報取得
        CURSOR C_WK1 IS
        SELECT
            霊柩車締切区分,
            霊柩車締切時刻
        FROM
            初期設定;
        R_WK1     C_WK1%ROWTYPE;
 /*******************************************************************************
  実行部
*******************************************************************************/
    BEGIN
        V_SYSDATE := SYSDATE;
        OPEN C_WK1;
        FETCH C_WK1 INTO R_WK1;
        IF C_WK1%FOUND THEN
            V_DEFSWKB := R_WK1.霊柩車締切区分;
            V_DEFSWTM := R_WK1.霊柩車締切時刻;
        ELSE
            V_DEFSWKB := -1; --前日
            V_DEFSWTM := 2100;
        END IF;

        CLOSE C_WK1;
        IF TO_NUMBER(TO_CHAR(V_SYSDATE, 'HH24MI')) >= V_DEFSWTM THEN
            RETURN TRUNC(V_SYSDATE) + 1 - V_DEFSWKB;
        ELSE
 --切替時刻になっていない場合は翌日から予約可
            RETURN TRUNC(V_SYSDATE) - V_DEFSWKB;
        END IF;
 /*******************************************************************************
  例外処理部
*******************************************************************************/
    EXCEPTION
        WHEN OTHERS THEN
            RETURN TRUNC(V_SYSDATE) + 2;
    END;
END;