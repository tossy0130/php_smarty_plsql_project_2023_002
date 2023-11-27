CREATE OR REPLACE PROCEDURE YOYAKU_ALLCHECK (
    P_SID IN VARCHAR2, --セッションID
    P_GYOCD IN NUMBER, --業者コード
    P_PASS IN NUMBER, --暗証番号
    P_UKENEND IN NUMBER, --受付年度
    P_UKECD IN NUMBER, --受付番号
    P_RSLT OUT NUMBER, --ステータス(0:正常終了　99:エラー)
    P_SQLCODE OUT NUMBER, --エラーコード
    P_SQLERRM OUT VARCHAR2 --エラーメッセージ
)
 /*******************************************************************************
* 作成者 : 夏目   
*******************************************************************************/
 /*======================================
  変数宣言
======================================*/ IS
    V_MCS_USE       YOYAKUDATAERR.MCS_USE%TYPE; --待合室利用区分
    V_RKS_USE       YOYAKUDATAERR.RKS_USE%TYPE; --霊柩車利用区分
    V_RKS_DTKB      YOYAKUDATAERR.RKS_DTKB%TYPE; --霊柩車開始日区分
    V_RKS_STIME     YOYAKUDATAERR.RKS_STIME%TYPE; --霊柩車出棺時刻
    V_SKJ_USE       YOYAKUDATAERR.SKJ_USE%TYPE; --式場利用区分
    V_KOK_DTKB      YOYAKUDATAERR.KOK_DTKB%TYPE; --告別式開始日区分
    V_KOK_STIME     YOYAKUDATAERR.KOK_STIME%TYPE; --告別式開式時刻
    V_TYA_USE       YOYAKUDATAERR.TYA_USE%TYPE; --通夜式利用区分
    V_TYA_DTKB      YOYAKUDATAERR.TYA_DTKB%TYPE; --通夜式開始日区分
    V_TYA_STIME     YOYAKUDATAERR.TYA_STIME%TYPE; --通夜式開式時刻
    V_SY7_USE       YOYAKUDATAERR.SY7_USE%TYPE; --初七日利用区分
    V_SY7_DTKB      YOYAKUDATAERR.SY7_DTKB%TYPE; --初七日開始日区分
    V_SY7_STIME     YOYAKUDATAERR.SY7_STIME%TYPE; --初七日開式時刻
    V_KASO_KB       YOYAKUDATAERR.KASO_KB%TYPE; --火葬区分
    V_AREA_KB       YOYAKUDATAERR.AREA_KB%TYPE; --地域区分
    V_SINSEI_SEI    YOYAKUDATAERR.SINSEI_SEI%TYPE; --申請者姓
    V_SINSEI_MEI    YOYAKUDATAERR.SINSEI_MEI%TYPE; --申請者名
    V_SINSEI_SKANA  YOYAKUDATAERR.SINSEI_SKANA%TYPE; --申請者姓かな
    V_SINSEI_MKANA  YOYAKUDATAERR.SINSEI_MKANA%TYPE; --申請者名かな
    V_SINSEI_TEL    YOYAKUDATAERR.SINSEI_TEL%TYPE; --連絡先ＴＥＬ
    V_SINSEI_TUDUK  YOYAKUDATAERR.SINSEI_TUDUK%TYPE; --申請者続柄
    V_SINSEI_ZIPC   YOYAKUDATAERR.SINSEI_ZIPC%TYPE; --申請者郵便
    V_SINSEI_ADR1   YOYAKUDATAERR.SINSEI_ADR1%TYPE; --申請者住所
    V_SINSEI_ADR2   YOYAKUDATAERR.SINSEI_ADR2%TYPE; --申請者住所２
    V_KOJIN_SEI     YOYAKUDATAERR.KOJIN_SEI%TYPE; --死亡者姓
    V_KOJIN_MEI     YOYAKUDATAERR.KOJIN_MEI%TYPE; --死亡者名
    V_KOJIN_SKANA   YOYAKUDATAERR.KOJIN_SKANA%TYPE; --死亡者姓かな
    V_KOJIN_MKANA   YOYAKUDATAERR.KOJIN_MKANA%TYPE; --死亡者名かな
    V_KOJIN_SEIBET  YOYAKUDATAERR.KOJIN_SEIBET%TYPE; --死亡者性別
    V_KOJIN_BIRTHG  YOYAKUDATAERR.KOJIN_BIRTHG%TYPE; --死亡者生年月日(暦区分)
    V_KOJIN_BIRTHY  YOYAKUDATAERR.KOJIN_BIRTHY%TYPE; --死亡者生年月日(年)
    V_KOJIN_BIRTHM  YOYAKUDATAERR.KOJIN_BIRTHM%TYPE; --死亡者生年月日(月)
    V_KOJIN_BIRTHD  YOYAKUDATAERR.KOJIN_BIRTHD%TYPE; --死亡者生年月日(日)
    V_KOJIN_DDATEG  YOYAKUDATAERR.KOJIN_DDATEG%TYPE; --死亡年月日(暦区分)
    V_KOJIN_DDATEY  YOYAKUDATAERR.KOJIN_DDATEY%TYPE; --死亡年月日(年)
    V_KOJIN_DDATEM  YOYAKUDATAERR.KOJIN_DDATEM%TYPE; --死亡年月日(月)
    V_KOJIN_DDATED  YOYAKUDATAERR.KOJIN_DDATED%TYPE; --死亡年月日(日)
    V_KOJIN_ZIPC    YOYAKUDATAERR.KOJIN_ZIPC%TYPE; --死亡者郵便
    V_KOJIN_ADR1    YOYAKUDATAERR.KOJIN_ADR1%TYPE; --死亡者住所
    V_KOJIN_ADR2    YOYAKUDATAERR.KOJIN_ADR2%TYPE; --死亡者住所２
    V_KOJIN_HZIPC   YOYAKUDATAERR.KOJIN_HZIPC%TYPE; --死亡者本籍郵便
    V_KOJIN_HONS1   YOYAKUDATAERR.KOJIN_HONS1%TYPE; --死亡者本籍
    V_KOJIN_HONS2   YOYAKUDATAERR.KOJIN_HONS2%TYPE; --死亡者本籍２
    V_FAX_SEND      YOYAKUDATAERR.FAX_SEND%TYPE; --FAX送信区分
    V_FAX_NO        YOYAKUDATAERR.FAX_NO%TYPE; --FAX番号
    V_RENRAKU       YOYAKUDATAERR.RENRAKU%TYPE; --連絡事項
    V_MADO_KB       YOYAKUDATAERR.MADO_KB%TYPE; --窓口区分
    V_RKS_SBASYO    YOYAKUDATAERR.RKS_SBASYO%TYPE; --霊柩車出棺場所 --2014/08/21
 --変数
    V_SDATE         DATE; --予約可能開始日
    V_RKSDATE       DATE; --霊柩車予約可能開始日 2014/11/17
    V_TYADATE       DATE; --通夜式予約可能開始日 2014/11/17
    V_SQLERRM       VARCHAR2(256); --エラーメッセージ
    V_DATE1         DATE; --チェック日付
    V_DATE2         DATE; --チェック日付
    V_RTCD          NUMBER; --リターンコード
    GET_YOYAKU_TIME NUMBER; -- 予約枠を時間に変える
 --2014/09/17
    V_ZIPC          火葬受付.申請者郵便%TYPE;
    V_ADR1          火葬受付.申請者住所%TYPE;
 --ｶｰｿﾙ宣言
 --入力情報
    CURSOR C_WK1 IS
    SELECT
        *
    FROM
        YOYAKUDATA
    WHERE
        SID = P_SID
        AND UKE_NEND = P_UKENEND
        AND UKE_NO = P_UKECD;
    CURSOR C_WK2 IS
    SELECT
        受付区分,
        業者コード
    FROM
        業者
    WHERE
        業者コード = P_GYOCD
        AND 削除フラグ <> 1;
    CURSOR C_WK3 IS
    SELECT
        *
    FROM
        火葬受付
    WHERE
        受付年度 = P_UKENEND
        AND 受付番号 = P_UKECD;
 --ﾚｺｰﾄﾞ宣言
    R_WK1           C_WK1%ROWTYPE; --入力データ
    R_WK2           C_WK2%ROWTYPE; --業者マスタ
    R_WK3           C_WK3%ROWTYPE; --火葬受付

 /*======================================
  本体
======================================*/
BEGIN
 --初期処理
    P_RSLT := 0;
    P_SQLCODE := 0;
    P_SQLERRM := NULL;
 --エラーデータクリア
    DELETE FROM YOYAKUDATAERR
    WHERE
        SID = P_SID
        AND UKE_NEND = P_UKENEND
        AND UKE_NO = P_UKECD;
    V_MCS_USE := NULL; --待合室利用区分
    V_RKS_USE := NULL; --霊柩車利用区分
    V_RKS_DTKB := NULL; --霊柩車開始日区分
    V_RKS_STIME := NULL; --霊柩車出棺時刻
    V_SKJ_USE := NULL; --式場利用区分
    V_KOK_DTKB := NULL; --告別式開始日区分
    V_KOK_STIME := NULL; --告別式開式時刻
    V_TYA_USE := NULL; --通夜式利用区分
    V_TYA_DTKB := NULL; --通夜式開始日区分
    V_TYA_STIME := NULL; --通夜式開式時刻
    V_SY7_USE := NULL; --初七日利用区分
    V_SY7_DTKB := NULL; --初七日開始日区分
    V_SY7_STIME := NULL; --初七日開式時刻
    V_KASO_KB := NULL; --火葬区分
    V_AREA_KB := NULL; --地域区分
    V_SINSEI_SEI := NULL; --申請者姓
    V_SINSEI_MEI := NULL; --申請者名
    V_SINSEI_SKANA := NULL; --申請者姓かな
    V_SINSEI_MKANA := NULL; --申請者名かな
    V_SINSEI_TEL := NULL; --連絡先ＴＥＬ
    V_SINSEI_TUDUK := NULL; --申請者続柄
    V_SINSEI_ZIPC := NULL; --申請者郵便
    V_SINSEI_ADR1 := NULL; --申請者住所
    V_SINSEI_ADR2 := NULL; --申請者住所２
    V_KOJIN_SEI := NULL; --死亡者姓
    V_KOJIN_MEI := NULL; --死亡者名
    V_KOJIN_SKANA := NULL; --死亡者姓かな
    V_KOJIN_MKANA := NULL; --死亡者名かな
    V_KOJIN_SEIBET := NULL; --死亡者性別
    V_KOJIN_BIRTHG := NULL; --死亡者生年月日(暦区分)
    V_KOJIN_BIRTHY := NULL; --死亡者生年月日(年)
    V_KOJIN_BIRTHM := NULL; --死亡者生年月日(月)
    V_KOJIN_BIRTHD := NULL; --死亡者生年月日(日)
    V_KOJIN_DDATEG := NULL; --死亡年月日(暦区分)
    V_KOJIN_DDATEY := NULL; --死亡年月日(年)
    V_KOJIN_DDATEM := NULL; --死亡年月日(月)
    V_KOJIN_DDATED := NULL; --死亡年月日(日)
    V_KOJIN_ZIPC := NULL; --死亡者郵便
    V_KOJIN_ADR1 := NULL; --死亡者住所
    V_KOJIN_ADR2 := NULL; --死亡者住所２
    V_KOJIN_HZIPC := NULL; --死亡者本籍郵便
    V_KOJIN_HONS1 := NULL; --死亡者本籍
    V_KOJIN_HONS2 := NULL; --死亡者本籍２
    V_FAX_SEND := NULL; --FAX送信区分
    V_FAX_NO := NULL; --FAX番号
    V_RENRAKU := NULL; --連絡事項
    V_MADO_KB := NULL; --窓口区分
    V_RKS_SBASYO := NULL; --霊柩車出棺場所 --2014/08/21
 --業者マスタのチェック
    OPEN C_WK2;
    FETCH C_WK2 INTO R_WK2;
    IF C_WK2%FOUND THEN
 --霊柩車業者はエラー
 --2015/01/07     IF r_WK2.受付区分 = 2 THEN
        IF (R_WK2.受付区分 = 2) OR (R_WK2.受付区分 = 9) THEN --2015/01/07
            P_RSLT := 99;
            P_SQLERRM := '予約内容の変更及び取消はできません。';
        END IF;
    END IF;

    CLOSE C_WK2;
    IF P_RSLT <> 0 THEN
        RETURN;
    END IF;
 --予約可能開始日取得
    V_SDATE := GET_YOYAKUBI();
    V_RKSDATE := GET_RKS_YOYAKUBI(); --2014/11/17
    V_TYADATE := GET_TYA_YOYAKUBI(); --2014/11/17
 --入力データオープン
    OPEN C_WK1;
    FETCH C_WK1 INTO R_WK1;
    IF C_WK1%FOUND THEN
 --火葬受付データオープン
        OPEN C_WK3;
        FETCH C_WK3 INTO R_WK3;
        IF C_WK3%FOUND THEN
            IF R_WK3.受付区分 = 1 THEN
                P_SQLERRM := '斎場にて確定受付済のため、予約内容の変更はできません。';
                P_RSLT := 99;
            END IF;

            IF R_WK3.受付区分 = 9 THEN
                P_SQLERRM := '対象の予約データは、既に取消されています。';
                P_RSLT := 99;
            END IF;
        ELSE
            P_SQLERRM := '対象の予約データは、削除されています。';
            P_RSLT := 99;
        END IF;

        IF P_RSLT = 99 THEN
            RETURN;
        END IF;
 ---------- 追加 23_1127 夏目
        CASE
            WHEN R_WK3.火葬予約枠番号 = 1 THEN
                GET_YOYAKU_TIME := 1000;
            WHEN R_WK3.火葬予約枠番号 = 2 THEN
                GET_YOYAKU_TIME := 1100;
            WHEN R_WK3.火葬予約枠番号 = 3 THEN
                GET_YOYAKU_TIME := 1300;
            WHEN R_WK3.火葬予約枠番号 = 4 THEN
                GET_YOYAKU_TIME := 1400;
            WHEN R_WK3.火葬予約枠番号 = 5 THEN
                GET_YOYAKU_TIME := 1500;
            WHEN R_WK3.火葬予約枠番号 = 6 THEN
                GET_YOYAKU_TIME := 1600;
            WHEN R_WK3.火葬予約枠番号 = 7 THEN
                GET_YOYAKU_TIME := 1700;
            ELSE
                GET_YOYAKU_TIME := 1000;
        END CASE;
 --- 元ソース

 /*
    CHECK_AKI(r_WK3.予約日付, r_WK3.火葬予約枠番号, r_WK1.SKJ_USE, r_WK1.TYA_USE, r_WK1.MCS_USE,r_WK1.RKS_USE
            , p_UKENEND, p_UKECD, v_RTCD, p_SQLCODE, v_SQLERRM);
    */
 --- 追加　修正 23_1127
        CHECK_AKI(R_WK3.予約日付, GET_YOYAKU_TIME, R_WK1.SKJ_USE, R_WK1.TYA_USE, R_WK1.MCS_USE, R_WK1.RKS_USE, P_UKENEND, P_UKECD, V_RTCD, P_SQLCODE, V_SQLERRM);
        IF (V_RTCD <> 0) THEN
            P_RSLT := 99;
            IF V_RTCD IN (8) THEN -- チェックを継続する場合
                CASE V_RTCD
                    WHEN 4 THEN
                        V_SKJ_USE := V_SQLERRM; -- 4:式場空きなし
                    WHEN 5 THEN
                        V_TYA_USE := V_SQLERRM; -- 5:式場予約枠なし
                    WHEN 6 THEN
                        V_TYA_USE := V_SQLERRM; -- 6:通夜式空きなし
                    WHEN 7 THEN
                        V_TYA_USE := V_SQLERRM; -- 7:通夜式予約枠なし
                    WHEN 8 THEN
                        V_MCS_USE := V_SQLERRM; -- 8:和室空きなし
                    WHEN 9 THEN
                        V_SKJ_USE := V_SQLERRM; -- 9:割当式場空きなし
                    WHEN 10 THEN
                        V_TYA_USE := V_SQLERRM; -- 10:割当通夜式場空きなし
                    WHEN 11 THEN
                        V_RKS_USE := V_SQLERRM; -- 11:霊柩車空きなし    ※                   (追加)
                    WHEN 12 THEN
                        V_RKS_USE := V_SQLERRM; -- 12:通夜霊柩車空きなし ※v_RKS_USE とりあえず        (追加)
                END CASE;
            ELSE
                P_SQLERRM := V_SQLERRM;
                RETURN;
            END IF;
        END IF;
 --2014/11/17 Start
 -- 予約締切日チェック
        IF (V_SDATE > R_WK3.予約日付 ) THEN
            P_SQLERRM := '予約受付時間を過ぎているため、内容の訂正はできません。キャンセルする場合は、予約を取消してください。';
            P_RSLT := 99;
            RETURN;
        END IF;
 -- 霊柩車締切日チェック
 --  IF (v_RKSDATE > r_WK3.予約日付 ) THEN
        IF (V_RKSDATE > (R_WK3.予約日付 + NVL(R_WK1.RKS_DTKB, 0))) THEN --2014/12/02
 -- 霊柩車利用情報が変更されているとエラー
            IF (NVL(R_WK1.RKS_USE, -1) <> NVL(R_WK3.霊きゅう車利用区分, -1)) OR (NVL(R_WK1.RKS_DTKB, -1) <> NVL(R_WK3.霊柩車開始日区分, -1)) OR (NVL(R_WK1.RKS_STIME, 'NULL') <> NVL(R_WK3.霊柩車出棺時刻, 'NULL')) OR (NVL(R_WK1.RKS_SBASYO, 'NULL') <> NVL(R_WK3.霊柩車出棺場所, 'NULL')) THEN
                P_SQLERRM := '霊柩車受付時間を過ぎているため、霊柩車の新規受付及び訂正、取消はできません。';
                P_RSLT := 99;
                RETURN;
            END IF;
        END IF;
 -- 通夜式締切日チェック
 --  IF (v_TYADATE > r_WK3.予約日付 ) THEN
        IF (V_TYADATE > (R_WK3.予約日付-1) ) THEN --2014/12/02
 -- 通夜式利用情報が変更されているとエラー
            IF (NVL(R_WK1.TYA_USE, -1) <> NVL(R_WK3.通夜利用区分, -1)) OR (NVL(R_WK1.TYA_DTKB, -1) <> NVL(R_WK3.通夜式開始日区分, -1)) OR (NVL(R_WK1.TYA_STIME, 'NULL') <> NVL(R_WK3.通夜式開始時刻, 'NULL')) THEN
                P_SQLERRM := '通夜式受付時間を過ぎているため、通夜式の受付及び訂正、取消はできません。';
                P_RSLT := 99;
                RETURN;
            END IF;
        END IF;
 --2014/11/17 End
 -- 火葬時刻, 出棺時刻、開式時刻の関連チェック
 --- 元ソース

 /*
    CHECK_TIME(r_WK3.予約日付, r_WK3.火葬予約枠番号
             , r_WK1.RKS_USE,  r_WK1.RKS_DTKB,  r_WK1.RKS_STIME
             , r_WK1.SKJ_USE,  r_WK1.KOK_DTKB,  r_WK1.KOK_STIME
             , r_WK1.TYA_USE,  r_WK1.TYA_DTKB,  r_WK1.TYA_STIME
             , p_UKENEND, p_UKECD,  v_RTCD, p_SQLCODE, v_SQLERRM
     );
     */
 --- 変更 追加 23_1127 夏目
        CHECK_TIME(R_WK3.予約日付, GET_YOYAKU_TIME, R_WK1.RKS_USE, R_WK1.RKS_DTKB, R_WK1.RKS_STIME, R_WK1.SKJ_USE, R_WK1.KOK_DTKB, R_WK1.KOK_STIME, R_WK1.TYA_USE, R_WK1.TYA_DTKB, R_WK1.TYA_STIME, P_UKENEND, P_UKECD, V_RTCD, P_SQLCODE, V_SQLERRM );
        IF V_RTCD <> 0 THEN
            P_RSLT := 99;
            IF V_RTCD IN (1, 2, 3) THEN -- チェックを継続する場合
                CASE V_RTCD
                    WHEN 1 THEN
                        V_RKS_DTKB := V_SQLERRM;
                    WHEN 2 THEN
                        V_KOK_DTKB := V_SQLERRM;
                    WHEN 3 THEN
                        V_TYA_DTKB := V_SQLERRM;
                END CASE;
            ELSE
                P_SQLERRM := V_SQLERRM;
                RETURN;
            END IF;
        END IF;
 --出棺場所必須
        IF (NVL(R_WK1.RKS_USE, 0) <> 0) THEN
            IF (R_WK1.RKS_SBASYO IS NULL) THEN
                V_RKS_SBASYO := '出棺場所を入力してください。';
                P_RSLT := 99;
            END IF;
        END IF;
 --申請者姓かなチェック
        IF R_WK1.SINSEI_SKANA IS NOT NULL THEN
 --全角カタカナのみOK
            IF CHK_KANA(R_WK1.SINSEI_SKANA, 0) <> 0 THEN
                V_SINSEI_SKANA := '全角カタカナで入力してください。';
                P_RSLT := 99;
            END IF;
        END IF;
 --申請者名かなチェック
        IF R_WK1.SINSEI_MKANA IS NOT NULL THEN
 --全角カタカナのみOK
            IF CHK_KANA(R_WK1.SINSEI_MKANA, 0) <> 0 THEN
                V_SINSEI_MKANA := '全角カタカナで入力してください。';
                P_RSLT := 99;
            END IF;
        END IF;
 --死亡者姓かなチェック
        IF R_WK1.KOJIN_SKANA IS NOT NULL THEN
 --全角カタカナのみOK
            IF CHK_KANA(R_WK1.KOJIN_SKANA, 0) <> 0 THEN
                V_KOJIN_SKANA := '全角カタカナで入力してください。';
                P_RSLT := 99;
            END IF;
        END IF;
 --死亡者名かなチェック
        IF R_WK1.KOJIN_MKANA IS NOT NULL THEN
 --全角カタカナのみOK
            IF CHK_KANA(R_WK1.KOJIN_MKANA, 0) <> 0 THEN
                V_KOJIN_MKANA := '全角カタカナで入力してください。';
                P_RSLT := 99;
            END IF;
        END IF;
 -- 生年月日チェック
        CHECK_HIZUKE(R_WK1.KOJIN_BIRTHG, R_WK1.KOJIN_BIRTHY, R_WK1.KOJIN_BIRTHM, R_WK1.KOJIN_BIRTHD, V_DATE1, V_RTCD, P_SQLCODE, V_SQLERRM );
        IF V_RTCD <> 0 THEN
            P_RSLT := 99;
            IF V_RTCD IN (1) THEN -- チェックを継続する場合
                CASE V_RTCD
                    WHEN 1 THEN
                        V_KOJIN_BIRTHG := V_SQLERRM;
                END CASE;
            ELSE
                P_SQLERRM := V_SQLERRM;
                RETURN;
            END IF;
        END IF;
 -- 死亡年月日チェック
        CHECK_HIZUKE(R_WK1.KOJIN_DDATEG, R_WK1.KOJIN_DDATEY, R_WK1.KOJIN_DDATEM, R_WK1.KOJIN_DDATED, V_DATE2, V_RTCD, P_SQLCODE, V_SQLERRM );
        IF V_RTCD <> 0 THEN
            P_RSLT := 99;
            IF V_RTCD IN (1) THEN -- チェックを継続する場合
                CASE V_RTCD
                    WHEN 1 THEN
                        V_KOJIN_DDATEG := V_SQLERRM;
                END CASE;
            ELSE
                P_SQLERRM := V_SQLERRM;
                RETURN;
            END IF;
        END IF;
 --生年月日 ＞ 死亡日エラー
        IF (V_DATE1 IS NOT NULL) AND (V_DATE2 IS NOT NULL) THEN
            IF (V_DATE1 > V_DATE2) THEN
                P_RSLT := 99;
                P_SQLERRM := '生年月日と死亡年月日の大小関係に誤りがあります。';
                RETURN;
            END IF;
        END IF;
 --fax送付する時にチェックする
        IF NVL(R_WK1.FAX_SEND, 0) = 1 THEN
 /* 提案していない
      --申請者姓必須チェック
--    IF r_WK1.SINSEI_SEI IS NULL OR r_WK1.SINSEI_MEI IS NULL  THEN
      IF r_WK1.SINSEI_SEI IS NULL THEN
        v_SINSEI_SEI := '申請者氏名を入力してください。';
        --v_SINSEI_MEI := ' ';
        p_RSLT := 99;
      END IF;
      --申請者連絡先必須チェック
      IF r_WK1.SINSEI_TEL IS NULL OR  r_WK1.SINSEI_TEL = '--' THEN
        v_SINSEI_TEL := '連絡先TELを入力してください。';
        p_RSLT := 99;
      END IF;
/* */
 --死亡者姓必須チェック
            IF R_WK1.KOJIN_SEI IS NULL OR R_WK1.KOJIN_MEI IS NULL THEN
                V_KOJIN_SEI := '死亡者氏名を入力してください。';
                V_KOJIN_MEI := ' ';
                P_RSLT := 99;
            END IF;
        END IF;
 /*
    -- 2014/10/22  確認画面で表示されない(web側の修正が必要と思われる)
    -- 登録時に変換する
    -- 郵便番号⇒住所１変換
    -- 申請者住所
    v_ZIPC  := r_WK1.SINSEI_ZIPC;
    v_ADR1  := r_WK1.SINSEI_ADR1;
    SELECT CVT_JTOY(v_ZIPC, v_ADR1) INTO v_ZIPC FROM DUAL;
    SELECT CVT_YTOJ(v_ZIPC, v_ADR1) INTO v_ADR1 FROM DUAL;
    UPDATE YOYAKUDATA SET SINSEI_ZIPC = v_ZIPC , SINSEI_ADR1 = v_ADR1
     WHERE SID      = p_SID
       AND UKE_NEND = p_UKENEND
       AND UKE_NO   = p_UKECD;
*/

        CLOSE C_WK3;
    ELSE --データなし
        P_RSLT := 99;
        P_SQLERRM := '入力データがありません。';
    END IF;

    CLOSE C_WK1;
    INSERT INTO YOYAKUDATAERR(
        SID,
        UKE_NEND,
        UKE_NO,
        MCS_USE --待合室利用区分
,
        RKS_USE --霊柩車利用区分
,
        RKS_DTKB --霊柩車開始日区分
,
        RKS_STIME --霊柩車出棺時刻
,
        SKJ_USE --式場利用区分
,
        KOK_DTKB --告別式開始日区分
,
        KOK_STIME --告別式開式時刻
,
        TYA_USE --通夜式利用区分
,
        TYA_DTKB --通夜式開始日区分
,
        TYA_STIME --通夜式開式時刻
,
        SY7_USE --初七日利用区分
,
        SY7_DTKB --初七日開始日区分
,
        SY7_STIME --初七日開式時刻
,
        KASO_KB --火葬区分
,
        AREA_KB --地域区分
,
        SINSEI_SEI --申請者姓
,
        SINSEI_MEI --申請者名
,
        SINSEI_SKANA --申請者姓かな
,
        SINSEI_MKANA --申請者名かな
,
        SINSEI_TEL --連絡先ＴＥＬ
,
        SINSEI_TUDUK --申請者続柄
,
        SINSEI_ZIPC --申請者郵便
,
        SINSEI_ADR1 --申請者住所
,
        SINSEI_ADR2 --申請者住所２
,
        KOJIN_SEI --死亡者姓
,
        KOJIN_MEI --死亡者名
,
        KOJIN_SKANA --死亡者姓かな
,
        KOJIN_MKANA --死亡者名かな
,
        KOJIN_SEIBET --死亡者性別
,
        KOJIN_BIRTHG --死亡者生年月日(暦区分)
,
        KOJIN_BIRTHY --死亡者生年月日(年)
,
        KOJIN_BIRTHM --死亡者生年月日(月)
,
        KOJIN_BIRTHD --死亡者生年月日(日)
,
        KOJIN_DDATEG --死亡年月日(暦区分)
,
        KOJIN_DDATEY --死亡年月日(年)
,
        KOJIN_DDATEM --死亡年月日(月)
,
        KOJIN_DDATED --死亡年月日(日)
,
        KOJIN_ZIPC --死亡者郵便
,
        KOJIN_ADR1 --死亡者住所
,
        KOJIN_ADR2 --死亡者住所２
,
        KOJIN_HZIPC --死亡者本籍郵便
,
        KOJIN_HONS1 --死亡者本籍
,
        KOJIN_HONS2 --死亡者本籍２
,
        FAX_SEND --FAX送信区分
,
        FAX_NO --FAX番号
,
        RENRAKU --連絡事項
,
        MADO_KB --窓口区分
,
        RKS_SBASYO --霊柩車出棺場所 --2014/08/21
    )VALUES(
        P_SID,
        P_UKENEND,
        P_UKECD,
        V_MCS_USE --待合室利用区分
,
        V_RKS_USE --霊柩車利用区分
,
        V_RKS_DTKB --霊柩車開始日区分
,
        V_RKS_STIME --霊柩車出棺時刻
,
        V_SKJ_USE --式場利用区分
,
        V_KOK_DTKB --告別式開始日区分
,
        V_KOK_STIME --告別式開式時刻
,
        V_TYA_USE --通夜式利用区分
,
        V_TYA_DTKB --通夜式開始日区分
,
        V_TYA_STIME --通夜式開式時刻
,
        V_SY7_USE --初七日利用区分
,
        V_AREA_KB --地域区分
,
        V_SY7_DTKB --初七日開始日区分
,
        V_SY7_STIME --初七日開式時刻
,
        V_KASO_KB --火葬区分
,
        V_SINSEI_SEI --申請者姓
,
        V_SINSEI_MEI --申請者名
,
        V_SINSEI_SKANA --申請者姓かな
,
        V_SINSEI_MKANA --申請者名かな
,
        V_SINSEI_TEL --連絡先ＴＥＬ
,
        V_SINSEI_TUDUK --申請者続柄
,
        V_SINSEI_ZIPC --申請者郵便
,
        V_SINSEI_ADR1 --申請者住所
,
        V_SINSEI_ADR2 --申請者住所２
,
        V_KOJIN_SEI --死亡者姓
,
        V_KOJIN_MEI --死亡者名
,
        V_KOJIN_SKANA --死亡者姓かな
,
        V_KOJIN_MKANA --死亡者名かな
,
        V_KOJIN_SEIBET --死亡者性別
,
        V_KOJIN_BIRTHG --死亡者生年月日(暦区分)
,
        V_KOJIN_BIRTHY --死亡者生年月日(年)
,
        V_KOJIN_BIRTHM --死亡者生年月日(月)
,
        V_KOJIN_BIRTHD --死亡者生年月日(日)
,
        V_KOJIN_DDATEG --死亡年月日(暦区分)
,
        V_KOJIN_DDATEY --死亡年月日(年)
,
        V_KOJIN_DDATEM --死亡年月日(月)
,
        V_KOJIN_DDATED --死亡年月日(日)
,
        V_KOJIN_ZIPC --死亡者郵便
,
        V_KOJIN_ADR1 --死亡者住所
,
        V_KOJIN_ADR2 --死亡者住所２
,
        V_KOJIN_HZIPC --死亡者本籍郵便
,
        V_KOJIN_HONS1 --死亡者本籍
,
        V_KOJIN_HONS2 --死亡者本籍２
,
        V_FAX_SEND --FAX送信区分
,
        V_FAX_NO --FAX番号
,
        V_RENRAKU --連絡事項
,
        V_MADO_KB --窓口区分
,
        V_RKS_SBASYO --霊柩車出棺場所 --2014/08/21
    );
    IF P_RSLT <> 0 AND P_SQLERRM IS NULL THEN
        P_RSLT := 99;
        P_SQLERRM := 'エラー項目を確認してください。';
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