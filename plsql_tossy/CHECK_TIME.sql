CREATE OR REPLACE PROCEDURE CHECK_TIME (
    P_YDATE IN DATE, --予約日付
    P_YWAKU IN NUMBER, --予約枠番号
    P_RKS IN NUMBER, --霊柩車利用区分(0:無  1:特別車 2:普通車)
    P_RKSDE IN NUMBER, --霊柩車開始日区分(-1:前日 0:当日)
    P_RKSTM IN VARCHAR2, --霊柩車出棺時刻
    P_SIKI IN NUMBER, --式場利用区分(0:無  1:有)
    P_SKJDE IN NUMBER, --告別式開始日区分(-1:前日 0:当日)
    P_SKJTM IN VARCHAR2, --告別式出棺時刻
    P_TUYA IN NUMBER, --通夜利用区分(0:無  1:有)
    P_TYADE IN NUMBER, --通夜式開始日区分(-1:前日 0:当日)
    P_TYATM IN VARCHAR2, --通夜式出棺時刻
    P_UKENEND IN NUMBER, --年度
    P_UKECD IN NUMBER, --受付番号
    P_RSLT OUT NUMBER, --ステータス(0:エラー無し
 --単項目チェック(メッセージは40桁以内）
 --           1:出棺時刻エラー
 --           2:告別式時刻エラー
 --           3:通夜式時刻エラー
 --関連チェック(画面上部に表示）
 --          99:関連チェック
 --          99:例外エラー
    P_SQLCODE OUT NUMBER, --エラーコード
    P_SQLERRM OUT VARCHAR2 --エラーメッセージ
)
 /*******************************************************************************
* 関数名 : CHECK_TIME
* 作成者 : 夏目 智徹
************************/
 /*======================================
  変数宣言
======================================*/ IS
    V_YOKAKU VARCHAR2(10);
    V_KSSTR  DATE; --火葬日時
    V_RKSTR  DATE; --霊柩車出棺日時
    V_SOUGI  DATE; --葬儀終了日時
    V_SKSTR  DATE; --開式開始日時
    V_SKEND  DATE; --開式終了日時
    V_RKDAY  DATE; --霊柩車出棺日時
    V_SKDAY  DATE; --告別式開式日時
    V_TYDAY  DATE; --告別式開式日時時
    V_SWAKU  NUMBER; --式場予約枠番号
    V_TWAKU  NUMBER; --式場(通夜)予約枠番号
    V_CKDAY  DATE; --重複チェック用
 --ｶｰｿﾙ宣言
 --火葬時間マスタ
 --- 元ソース

 /*
  CURSOR c_WK1(v_YWAKU NUMBER)  IS
  SELECT YT.*
    FROM 予約枠マスタ YW, 予約時間マスタ YT
   WHERE YW.予約枠番号 = v_YWAKU
--   AND YW.適用開始日 = (SELECT MAX(適用開始日) FROM 予約枠マスタ WHERE 適用開始日 <= p_YDATE)
     AND YW.予約時間番号 = YT.予約時間番号;
*/
 -------- CURSOR c_WK1 追加 01 23_1127  夏目

 /*
   CURSOR c_WK1(v_YWAKU NUMBER) IS
   SELECT YWM.*
      FROM 予約枠名称 YWM
     WHERE YWM.予約枠時刻 = v_YWAKU
       AND YWM.適用開始日 >= (SELECT MAX(適用開始日) FROM 予約枠 WHERE 適用開始日 <= p_YDATE);
   */
 -------- CURSOR c_WK1 追加 02 23_1127  夏目
    CURSOR C_WK1(
        V_YWAKU NUMBER
    ) IS
    SELECT
        YWK.予約枠数,
        YWN.*
    FROM
        予約枠   YWK,
        予約枠名称 YWN
    WHERE
        YWK.KEY1 = 0 --火葬炉枠
        AND YWK.KEY3 = 0 --火葬炉
        AND YWK.適用開始日 = (
            SELECT
                MAX(適用開始日)
            FROM
                予約枠
            WHERE
                適用開始日 <= P_YDATE
        )
        AND YWK.適用開始日 = YWN.適用開始日
        AND YWK.KEY1 = YWN.KEY1
        AND YWK.KEY2 = YWN.KEY2
 --   AND YWN.予約枠時刻 = 1100;
        AND YWN.予約枠時刻 = V_YWAKU;
 --式場枠番号確認用
    CURSOR C_WK2(
        V_TYPE VARCHAR2
    ) IS
    SELECT
        YWM.予約枠番号 AS 式場枠番号
    FROM
        予約枠マスタ  YWM,
        予約時間マスタ YJM
    WHERE
        YWM.予約時間番号 = YJM.予約時間番号
        AND YWM.適用開始日 <= P_YDATE
        AND ((YWM.適用終了日 >= P_YDATE)
        OR (YWM.適用終了日 IS NULL))
        AND YJM.予約種別区分 = V_TYPE
    ORDER BY
        YWM.予約枠番号;
    CURSOR C_WK3 IS
    SELECT
        火葬予約枠番号,
        告別式開始日区分,
        告別式開始時刻
    FROM
        火葬受付
    WHERE
        予約日付 = P_YDATE -- 同じ日
        AND 受付区分 <> 9 -- 取消除く
        AND 式場利用区分 = 1 -- 式場利用者
        AND (受付年度 <> P_UKENEND
        OR 受付番号 <> P_UKECD); --自分以外
    CURSOR C_WK4 IS
    SELECT
        通夜式開始日区分,
        通夜式開始時刻
    FROM
        火葬受付
    WHERE
        予約日付 = P_YDATE -- 同じ日
        AND 受付区分 <> 9 -- 取消除く
        AND 通夜利用区分 = 1 -- 通夜利用者
        AND (受付年度 <> P_UKENEND
        OR 受付番号 <> P_UKECD); --自分以外
 --ﾚｺｰﾄﾞ宣言
    R_WK1    C_WK1%ROWTYPE;
    R_WK2    C_WK2%ROWTYPE;
    R_WK3    C_WK3%ROWTYPE;
    R_WK4    C_WK4%ROWTYPE;
 /*======================================
  本体
======================================*/
BEGIN
 --初期処理
    P_RSLT := 0;
    P_SQLCODE := 0;
    P_SQLERRM := NULL;
    V_YOKAKU := NULL;
    V_KSSTR := NULL;
    V_RKSTR := NULL;
    V_SOUGI := NULL;
    V_SKSTR := NULL;
    V_SKEND := NULL;
    V_RKDAY := NULL;
    V_SKDAY := NULL;
    V_TYDAY := NULL;
    V_CKDAY := NULL;
 --予約日を文字列に変換
    V_YOKAKU := TO_CHAR(P_YDATE, 'YYYY/MM/DD');
 --霊柩車予約日時
    IF (P_RKSDE IS NOT NULL) AND (P_RKSTM IS NOT NULL) THEN
        V_RKDAY := TO_DATE(V_YOKAKU
                           || ' '
                           || P_RKSTM, 'YYYY/MM/DD HH24:MI');
        IF (P_RKSDE = -1) THEN
            V_RKDAY := V_RKDAY - 1;
        END IF;
    END IF;
 --告別式開式予約日時
    IF (P_SKJTM IS NOT NULL) THEN
        V_SKDAY := TO_DATE(V_YOKAKU
                           || ' '
                           || P_SKJTM, 'YYYY/MM/DD HH24:MI');
        IF (NVL(P_SKJDE, 0) = -1) THEN
            V_SKDAY := V_SKDAY - 1;
        END IF;
    END IF;
 --通夜式開式予約日時
    IF (P_TYATM IS NOT NULL) THEN
        V_TYDAY := TO_DATE(V_YOKAKU
                           || ' '
                           || P_TYATM, 'YYYY/MM/DD HH24:MI');
        IF (NVL(P_TYADE, 0) = -1) THEN
            V_TYDAY := V_TYDAY - 1;
        END IF;
    END IF;
 --DBMS_OUTPUT.PUT_LINE('霊柩車出棺時刻 ' || TO_CHAR(v_RKDAY, 'YYYY/MM/DD HH24:MI'));
 --DBMS_OUTPUT.PUT_LINE('式場開始時刻 ' || TO_CHAR(v_SKDAY, 'YYYY/MM/DD HH24:MI'));
 --DBMS_OUTPUT.PUT_LINE('通夜開始時刻 ' || TO_CHAR(v_TYDAY, 'YYYY/MM/DD HH24:MI'));
 --火葬時間マスタ取得
    OPEN C_WK1(P_YWAKU);
    FETCH C_WK1 INTO R_WK1;
    IF C_WK1%NOTFOUND THEN
        P_RSLT := 99;
        P_SQLERRM := '火葬枠マスタが読み込みできません。斎場にお問い合わせください。';
        CLOSE C_WK1;
        RETURN;
    END IF;
 --- 元ソース

 /*
    v_KSSTR := TO_DATE(V_YOKAKU || ' ' || REPLACE(TO_CHAR(r_WK1.予約開始時刻/100,     'FM00.00'), '.', ':'), 'YYYY/MM/DD HH24:MI'); 
    v_RKSTR := v_KSSTR - (NVL(r_WK1.出棺時刻,0) / 1440); --火葬時刻の30分前
    */
 --------- 変更 23_1127 夏目
    V_KSSTR := TO_DATE(V_YOKAKU
                       || ' '
                       || REPLACE(TO_CHAR(R_WK1.開始時刻/100, 'FM00.00'), '.', ':'), 'YYYY/MM/DD HH24:MI');
    V_RKSTR := V_KSSTR - (NVL(R_WK1.出棺時刻, 0) / 1440); --火葬時刻の30分前
 --DBMS_OUTPUT.PUT_LINE('火葬時刻 ' || TO_CHAR(v_KSSTR, 'YYYY/MM/DD HH24:MI'));
 --DBMS_OUTPUT.PUT_LINE('基本出棺時刻 ' || TO_CHAR(v_RKSTR, 'YYYY/MM/DD HH24:MI'));
    CLOSE C_WK1;
 --同じ日に式場利用があるかチェック
 --告別式
    IF (NVL(P_SIKI, 0) <> 0) THEN --式場利用あり
        OPEN C_WK3;
        LOOP
            FETCH C_WK3 INTO R_WK3;
            EXIT WHEN C_WK3%NOTFOUND;
 --火葬時間重複
            IF (P_YWAKU = R_WK3.火葬予約枠番号) THEN
                P_RSLT := 99;
 --2014/12/02          p_SQLERRM := '式場利用の火葬時間が重複するため、この火葬時間では予約できません。';
                P_SQLERRM := 'ご予約済みの式場利用者と火葬時間が重複するため、この火葬時間では式場のご利用はできません。'; --2014/12/02
                CLOSE C_WK3;
                RETURN;
            END IF;

            IF (V_SKDAY IS NOT NULL) THEN --時間入力あり
 --開始時刻重複
                IF (R_WK3.告別式開始時刻 IS NOT NULL) THEN
                    V_CKDAY := TO_DATE(V_YOKAKU
                                       || ' '
                                       || R_WK3.告別式開始時刻, 'YYYY/MM/DD HH24:MI');
                    IF (NVL(R_WK3.告別式開始日区分, 0) = -1) THEN
                        V_CKDAY := V_CKDAY - 1;
                    END IF;
 -- チェック有無保留事項(14/10/22現在）
 --           時間選択30分単位なので前後30分以上離さないとエラー（15分単位にすれば前後15分となる）
                    IF (V_CKDAY = V_SKDAY) THEN
                        P_RSLT := 99;
 --2014/12/02                p_SQLERRM := '式場利用の開始時刻が重複するため、開始時刻を変更してください。';
                        P_SQLERRM := 'ご予約済みの式場利用者と式開始時刻が重複するため、開始時刻を変更してください。'; --2014/12/02
                        CLOSE C_WK3;
                        RETURN;
                    END IF;
                END IF;
            END IF;
        END LOOP;

        CLOSE C_WK3;
    END IF;
 --通夜式
    IF (NVL(P_TUYA, 0) <> 0
    AND V_TYDAY IS NOT NULL) THEN --通夜式利用あり
        OPEN C_WK4;
        LOOP
            FETCH C_WK4 INTO R_WK4;
            EXIT WHEN C_WK4%NOTFOUND;
 --開始時刻重複
            IF (R_WK4.通夜式開始時刻 IS NOT NULL) THEN
                V_CKDAY := TO_DATE(V_YOKAKU
                                   || ' '
                                   || R_WK4.通夜式開始時刻, 'YYYY/MM/DD HH24:MI');
                IF (NVL(R_WK4.通夜式開始日区分, 0) = -1) THEN
                    V_CKDAY := V_CKDAY - 1;
                END IF;
 -- チェック有無保留事項(14/10/22現在）
                IF (V_CKDAY = V_TYDAY) THEN
                    P_RSLT := 99;
 --2014/12/02           p_SQLERRM := '通夜式利用の開始時刻が重複するため、開始時刻を変更してください。';
                    P_SQLERRM := 'ご予約済みの通夜式利用者と通夜式開始時刻が重複するため、開始時刻を変更してください。'; --2014/12/02
                    CLOSE C_WK4;
                    RETURN;
                END IF;
            END IF;
        END LOOP;

        CLOSE C_WK4;
    END IF;
 --霊柩車予約日時チェック-----------------------------------------------------------------
    IF (NVL(P_RKS, 0) <> 0) THEN --霊柩車利用あり
        IF (V_RKDAY IS NULL) THEN
            P_RSLT := 1;
            P_SQLERRM := '出棺時刻を入力してください。';
            RETURN;
        END IF;
 -- 出棺時刻 > 火葬時刻－基本出棺時間
        IF (V_RKDAY > V_RKSTR) THEN
            P_RSLT := 99;
            P_SQLERRM := '出棺時刻は、火葬時刻に間に合いません。'
                         || TO_CHAR(V_RKSTR, 'HH24:MI')
                            || 'より前を指定してください。';
            RETURN;
        END IF;
    END IF;
 --式場利用(告別式)の場合-----------------------------------------------------------------
    IF NVL(P_SIKI, 0) <> 0 THEN --式場利用あり
        IF (V_SKDAY IS NULL) THEN
            P_RSLT := 2;
            P_SQLERRM := '開始時刻を入力してください。';
            RETURN;
        END IF;
 --式場枠番号取得
        OPEN C_WK2('SKJ');
        FETCH C_WK2 INTO R_WK2;
        IF C_WK2%FOUND THEN
            V_SWAKU := R_WK2.式場枠番号;
        END IF;

        CLOSE C_WK2;
        OPEN C_WK1(V_SWAKU);
        FETCH C_WK1 INTO R_WK1;
        IF C_WK1%NOTFOUND THEN
            P_RSLT := 99;
            P_SQLERRM := '式場枠マスタが読み込みできません。斎場にお問い合わせください。';
            CLOSE C_WK1;
            RETURN;
        END IF;
 --- 元ソース

 /*
    v_SKSTR := TO_DATE(V_YOKAKU || ' ' || REPLACE(TO_CHAR(NVL(r_WK1.開式開始時刻, r_WK1.予約開始時刻)/100, 'FM00.00'), '.', ':'), 'YYYY/MM/DD HH24:MI'); 
    v_SKEND := TO_DATE(V_YOKAKU || ' ' || REPLACE(TO_CHAR(NVL(r_WK1.開式終了時刻, r_WK1.予約終了時刻)/100, 'FM00.00'), '.', ':'), 'YYYY/MM/DD HH24:MI'); 
    v_RKSTR := NVL(v_SKDAY,v_SKSTR) - r_WK1.出棺時刻 / 1440; --開始時刻の30分前
    v_SOUGI := NVL(v_KSSTR,v_SKEND) - r_WK1.葬儀時間 / 1440;     --火葬時刻の60分前
    */
 --------- 追加 変更 23_1127 夏目
        V_SKSTR := TO_DATE(V_YOKAKU
                           || ' '
                           || REPLACE(TO_CHAR(R_WK1.開始時刻 /100, 'FM00.00'), '.', ':'), 'YYYY/MM/DD HH24:MI');
        V_SKEND := TO_DATE(V_YOKAKU
                           || ' '
                           || REPLACE(TO_CHAR(R_WK1.開始時刻 /100, 'FM00.00'), '.', ':'), 'YYYY/MM/DD HH24:MI');
        V_RKSTR := NVL(V_SKDAY, V_SKSTR) - R_WK1.出棺時刻 / 1440; --開始時刻の30分前
        V_SOUGI := NVL(V_KSSTR, V_SKEND) - R_WK1.終了時刻 / 1440; --火葬時刻の60分前
 --DBMS_OUTPUT.PUT_LINE('開式開始範囲 ' || TO_CHAR(v_SKSTR, 'YYYY/MM/DD HH24:MI'));
 --DBMS_OUTPUT.PUT_LINE('開式終了範囲 ' || TO_CHAR(v_SKEND, 'YYYY/MM/DD HH24:MI'));
 --DBMS_OUTPUT.PUT_LINE('基本出棺時刻 ' || TO_CHAR(v_RKSTR, 'YYYY/MM/DD HH24:MI'));
 --DBMS_OUTPUT.PUT_LINE('終了予定時刻 ' || TO_CHAR(v_KSSTR, 'YYYY/MM/DD HH24:MI'));
        CLOSE C_WK1;
 --開始時刻チェック
        IF (P_SKJDE IS NOT NULL) AND (P_SKJTM IS NOT NULL) THEN
 --利用可能時間外
            IF (P_SKJDE <> 0) OR (V_SKDAY < V_SKSTR) OR (V_SKDAY > V_SKEND) THEN
                P_RSLT := 99;
                P_SQLERRM := '開始時刻は、当日の'
                             || TO_CHAR(V_SKSTR, 'HH24:MI')
                                || 'から'
                                || TO_CHAR(V_SKEND, 'HH24:MI')
                                   || 'までです。';
                RETURN;
            END IF;
 --開始時刻 ＞ 火葬時刻-葬儀時間
            IF (V_SKDAY > V_SOUGI) THEN
                P_RSLT := 99;
                P_SQLERRM := '開始時刻は、火葬時刻に間に合いません。'
                             || TO_CHAR(V_SOUGI, 'HH24:MI')
                                || 'より前を指定してください。';
                RETURN;
            END IF;
 --霊柩車予約日時チェック
            IF (NVL(P_RKS, 0) <> 0) AND (V_RKDAY IS NOT NULL) AND (P_RKSDE = 0) THEN --当日なら
 -- 出棺時刻 > 開始時刻－基本出棺時間
                IF (V_RKDAY > V_RKSTR) THEN
                    P_RSLT := 99;
                    P_SQLERRM := '出棺時刻は、開始時刻に間に合いません。'
                                 || TO_CHAR(V_RKSTR, 'HH24:MI')
                                    || 'より前を指定してください。';
                    RETURN;
                END IF;
            END IF;
        END IF;
    END IF;
 --通夜式利用の場合------------------------------------------------------------------
    IF NVL(P_TUYA, 0) <> 0 THEN
        IF (V_TYDAY IS NULL) THEN
            P_RSLT := 3;
            P_SQLERRM := '開始時刻を入力してください。';
            RETURN;
        END IF;
 --通夜枠番号取得
        OPEN C_WK2('TYA');
        FETCH C_WK2 INTO R_WK2;
        IF C_WK2%FOUND THEN
            V_TWAKU := R_WK2.式場枠番号;
        END IF;

        CLOSE C_WK2;
        OPEN C_WK1(V_TWAKU);
        FETCH C_WK1 INTO R_WK1;
        IF C_WK1%NOTFOUND THEN
            P_RSLT := 99;
            P_SQLERRM := '式場枠マスタが読み込みできません。斎場にお問い合わせください。';
            CLOSE C_WK1;
            RETURN;
        END IF;
 --- 元ソース

 /*
    v_SKSTR := TO_DATE(V_YOKAKU || ' ' || REPLACE(TO_CHAR(NVL(r_WK1.開式開始時刻, r_WK1.予約開始時刻)/100, 'FM00.00'), '.', ':'), 'YYYY/MM/DD HH24:MI'); 
    v_SKSTR := v_SKSTR - 1; --1日前
    v_SKEND := TO_DATE(V_YOKAKU || ' ' || REPLACE(TO_CHAR(NVL(r_WK1.開式終了時刻, r_WK1.予約終了時刻)/100, 'FM00.00'), '.', ':'), 'YYYY/MM/DD HH24:MI'); 
    v_SKEND := v_SKEND - 1; --1日前
    v_RKSTR := NVL(v_TYDAY, v_SKSTR) - r_WK1.出棺時刻 / 1440; --開始時刻の30分前
    */
 ---------　追加 変更 23_1127 夏目
        V_SKSTR := TO_DATE(V_YOKAKU
                           || ' '
                           || REPLACE(TO_CHAR(R_WK1.開始時刻 /100, 'FM00.00'), '.', ':'), 'YYYY/MM/DD HH24:MI');
        V_SKSTR := V_SKSTR - 1; --1日前
        V_SKEND := TO_DATE(V_YOKAKU
                           || ' '
                           || REPLACE(TO_CHAR(R_WK1.終了時刻 /100, 'FM00.00'), '.', ':'), 'YYYY/MM/DD HH24:MI');
        V_SKEND := V_SKEND - 1; --1日前
        V_RKSTR := NVL(V_TYDAY, V_SKSTR) - R_WK1.出棺時刻 / 1440; --開始時刻の30分前
 --DBMS_OUTPUT.PUT_LINE('開式開始範囲 ' || TO_CHAR(v_SKSTR, 'YYYY/MM/DD HH24:MI'));
 --DBMS_OUTPUT.PUT_LINE('開式終了範囲 ' || TO_CHAR(v_SKEND, 'YYYY/MM/DD HH24:MI'));
 --DBMS_OUTPUT.PUT_LINE('基本出棺時刻 ' || TO_CHAR(v_RKSTR, 'YYYY/MM/DD HH24:MI'));
        CLOSE C_WK1;
 --開始時刻チェック
        IF (P_SKJDE IS NOT NULL) AND (P_SKJTM IS NOT NULL) THEN
 --利用可能時間外
            IF (P_SKJDE <> 0) OR (V_TYDAY < V_SKSTR) OR (V_TYDAY > V_SKEND) THEN
                P_RSLT := 99;
                P_SQLERRM := '通夜式の開始時刻は、前日の'
                             || TO_CHAR(V_SKSTR, 'HH24:MI')
                                || 'から'
                                || TO_CHAR(V_SKEND, 'HH24:MI')
                                   || 'までです。';
                RETURN;
            END IF;
 --霊柩車予約日時チェック
            IF (NVL(P_RKS, 0) <> 0) AND (V_RKDAY IS NOT NULL) AND (P_RKSDE = -1) THEN --前日なら
 -- 出棺時刻 > 開始時刻-30分
                IF (V_RKDAY > V_RKSTR) THEN
                    P_RSLT := 99;
                    P_SQLERRM := '出棺時刻は、通夜式の開始時刻に間に合いません。'
                                 || TO_CHAR(V_RKSTR, 'HH24:MI')
                                    || 'より前を指定してください。';
                    RETURN;
                END IF;
            END IF;
        END IF;
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