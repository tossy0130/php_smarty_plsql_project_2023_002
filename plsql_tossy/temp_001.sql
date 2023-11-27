CREATE OR REPLACE PROCEDURE YOYAKU_CHECK (
    P_SID IN VARCHAR2, --セッションID
    P_GYOCD IN NUMBER, --業者コード
    P_PASS IN NUMBER, --暗証番号
    P_YDATE IN DATE, --予約日付
    P_YWAKU IN NUMBER, --火葬予約枠番号
    P_SIKI IN NUMBER, --式場利用区分(0:無  1:有)
    P_UKENEND OUT NUMBER, --受付年度
    P_UKECD OUT NUMBER, --受付番号
    P_RSLT OUT NUMBER, --ステータス(0:正常終了　99:エラー)
    P_SQLCODE OUT NUMBER, --エラーコード
    P_SQLERRM OUT VARCHAR2 --エラーメッセージ
)
 /*******************************************************************************
* 関数名 : YOYAKU_CHECK
* 作成者 : 夏目
* 作成日 : 2023/09/04
* 概要   : Web予約用受付前予約枠確保プロシージャ
* 機能   : 予約日と火葬の予約枠番号を受取り、仮予約して受付番号を戻す
* 履歴   : 
*******************************************************************************/
 /*======================================
  変数宣言
======================================*/ IS
    V_GYONM            火葬受付.業者名%TYPE;
    V_MAIL             火葬受付.メールアドレス%TYPE;
    V_GYOTEL           火葬受付.電話番号%TYPE;
    V_UKETNCD          火葬受付.受付担当コード%TYPE;
    V_UKETNNM          火葬受付.受付担当者%TYPE;
    V_UKEDATE          火葬受付.受付日時%TYPE;
    V_NEW              NUMBER; --新規フラグ(0:非新規(既存流用) 1:新規)
 ---- 前橋用　追加　23_1109 夏目
    G_YOYAKU_WAKU_TIME NUMBER; ---  A0203011 プロシージャ 予約時間 insert用
 --ｶｰｿﾙ宣言
 --仮押さえ情報
    CURSOR C_WK1 IS
    SELECT
        UKE_NEND,
        UKE_NO
    FROM
        KARI_YOYAKU -- ※テーブル
    WHERE
        SID = P_SID
        AND GYO_CD = P_GYOCD
        AND GYO_PASS = P_PASS;
 --業者情報
    CURSOR C_WK2 IS
    SELECT
        GM.業者名,
        GM.電話番号,
        AM.メールアドレス,
        GM.受付区分 --2014/09/16
    FROM
        業者   GM -- ※テーブル
,
        暗証番号 AM -- ※テーブル
    WHERE
        GM.業者コード = AM.業者コード
        AND AM.業者コード = P_GYOCD
        AND AM.暗証番号 = P_PASS;
 --2014/10/23
    CURSOR C_WK3 IS
    SELECT
        火葬予約枠番号
    FROM
        火葬受付 -- ※テーブル
    WHERE
        予約日付 = P_YDATE -- 同じ日
        AND 受付区分 <> 9 -- 取消除く
        AND 式場利用区分 = 1 -- 式場利用者
        AND (受付年度 <> NVL(P_UKENEND, 0)
        OR 受付番号 <> NVL(P_UKECD, -1)); --自分以外
 --ﾚｺｰﾄﾞ宣言
    R_WK1              C_WK1%ROWTYPE;
    R_WK2              C_WK2%ROWTYPE;
    R_WK3              C_WK3%ROWTYPE; --2014/10/23

 /*======================================
  本体
======================================*/
BEGIN
 --初期処理
    P_RSLT := 0;
    P_SQLCODE := 0;
    P_SQLERRM := NULL;
 --仮押さえキャンセル
 -------- 追記　変更 23_1109 夏目
 -- YOYAKU_CANCEL(p_SID, p_GYOCD, p_PASS, p_RSLT, p_SQLCODE, p_SQLERRM);
 --業者情報取得
    OPEN C_WK2;
    FETCH C_WK2 INTO R_WK2;
    IF C_WK2%FOUND THEN
 --2014/09/16
        IF R_WK2.受付区分 = 2 THEN
            P_RSLT := 99;
            P_SQLERRM := '仮予約することはできません。';
            CLOSE C_WK2;
            RETURN;
        END IF;

        V_GYONM := R_WK2.業者名;
        V_MAIL := R_WK2.メールアドレス;
        V_GYOTEL := R_WK2.電話番号;
    ELSE
        V_GYONM := NULL;
        V_MAIL := NULL;
        V_GYOTEL := NULL;
    END IF;

    CLOSE C_WK2;
 --仮押さえ情報取得
    OPEN C_WK1;
    FETCH C_WK1 INTO R_WK1;
    IF C_WK1%FOUND THEN
        P_UKENEND := R_WK1.UKE_NEND;
        P_UKECD := R_WK1.UKE_NO;
        V_NEW := 0;
    ELSE
        P_UKENEND := NULL;
        P_UKECD := NULL;
        V_NEW := 1;
    END IF;

    CLOSE C_WK1;
 /*
  --同じ日に式場利用があるかチェック 2014/10/23
  IF (NVL(p_SIKI, 0) <> 0) THEN  --式場利用あり
    OPEN c_WK3;
    LOOP
       FETCH c_WK3 INTO r_WK3;
       EXIT WHEN c_WK3%NOTFOUND;
       --火葬時間重複
       IF (p_YWAKU = r_WK3.火葬予約枠番号) THEN
          p_RSLT := 99;
          p_SQLERRM := '式場利用の火葬時間が重複するため、この火葬時間では予約できません。';
          CLOSE c_WK3;
          RETURN;
       END IF;
    END LOOP;
    CLOSE c_WK3;
  END IF;
*/
 --関連情報セット
    V_UKEDATE := SYSDATE; --受付日時
    V_UKETNCD := 1; --受付担当コード
 --受付担当者名の取得
    SELECT
        担当者名 INTO V_UKETNNM
    FROM
        担当者 -- ※テーブル
    WHERE
        担当者コード = V_UKETNCD;
 -------　追記 前橋用 2023-1109 夏目
 --- 後で前橋用の枠へ変更 1：10:00　～ 7:17:00 コロンは取る
    CASE P_YWAKU
        WHEN 3 THEN
            G_YOYAKU_WAKU_TIME := 1000;
        WHEN 4 THEN
            G_YOYAKU_WAKU_TIME := 1100;
        WHEN 5 THEN
            G_YOYAKU_WAKU_TIME := 1300;
        WHEN 6 THEN
            G_YOYAKU_WAKU_TIME := 1400;
        WHEN 7 THEN
            G_YOYAKU_WAKU_TIME := 1500;
        WHEN 8 THEN
            G_YOYAKU_WAKU_TIME := 1600;
        WHEN 9 THEN
            G_YOYAKU_WAKU_TIME := 1700;
        ELSE
            G_YOYAKU_WAKU_TIME := 0; --- 一応 0　を設定。
    END CASE;
 --受付登録（WEB 津市）を前橋用に変更
    UPDATE_UKETSUKE(P_GYOCD --業者コード
    , V_GYONM --業者名
    , P_PASS --暗証番号
    , V_MAIL --メールアドレス
    , NULL --確認書送信先FAX番号
    , V_GYOTEL --連絡先電話番号
    , P_YDATE --予約日付
    , P_YWAKU --予約枠番号
    , NULL --市外フラグ(0:非市外  1:市外)
    , 0 --大型炉フラグ(0:非大型炉  1:大型炉)
    , 0 --霊きゅう車利用区分(0:無 1:有)
    , P_SIKI --式場利用区分(0:無  1:有)
    , 0 --通夜利用区分(0:無  1:有)
    , V_UKETNCD --受付担当者コード
    , V_UKETNNM --受付担当者名
    , NULL --窓口区分
    , NULL --備考
    , NULL --火葬区分
    , NULL --申請者姓
    , NULL --申請者名
    , NULL --申請者姓かな
    , NULL --申請者名かな
    , NULL --申請者郵便
    , NULL --申請者住所
    , NULL --申請者住所２
    , NULL --申請者電話番号
    , NULL --申請者続柄
    , NULL --死亡者姓
    , NULL --死亡者名
    , NULL --死亡者姓かな
    , NULL --死亡者名かな
    , NULL --死亡者郵便
    , NULL --死亡者住所
    , NULL --死亡者住所２
    , NULL --死亡者本籍郵便
    , NULL --死亡者本籍
    , NULL --死亡者本籍２
    , NULL --死亡者性別
    , NULL --死亡者生年月日
    , NULL --死亡年月日
    , NULL --待合室利用区分
    , NULL --霊柩車開始日区分
    , NULL --霊柩車出棺時刻
    , NULL --霊柩車出棺場所
    , NULL --告別式開始日区分
    , NULL --告別式開始時刻
    , NULL --通夜式開始日区分
    , NULL --通夜式開始時刻
    , NULL --初七日利用区分
    , NULL --初七日開始日区分
    , NULL --初七日開始時刻
    , NULL --FAX送信区分
    , NULL --連絡事項
    , 0 --更新SEQ
    , 0 --更新フラグ(0:新規 1:更新)
    , 0 --取消フラグ(0:非取り消し 1:取り消し)
    , V_UKEDATE --受付日付
    , P_UKENEND --年度
    , P_UKECD --受付番号
    , P_RSLT --ステータス(0:正常終了　99:エラー)
    , P_SQLCODE --エラーコード
    , P_SQLERRM --エラーメッセージ
    );
 --受付登録（WEB 前橋）=========== WEBの枠取得が、津市のままなので、エラーが返るので、一旦コメントアウト

 /*
A0203011
(  p_GYOCD     --業者コード
   ,v_GYONM    --業者名
   ,p_PASS     --暗証番号
   ,v_MAIL     --メールアドレス
   ,NULL       --確認書送信先FAX番号
   ,v_GYOTEL      --連絡先電話番号
   ,p_YDATE     --予約日付
   ,g_yoyaku_waku_time    --予約時刻 ★★★ 変更　23_1109 夏目
   ,0    --式場予約時間 ※23_1011パラメータなし
   ,0    --市外フラグ(0:非市外  1:市外) ★★★ 変更 23_1109 夏目
   ,0    --大型炉フラグ(0:非大型炉  1:大型炉)
   ,0    --霊きゅう車利用区分(0:無 1:有)
   ,p_SIKI     --式場利用区分(0:無  1:大式場  2:小式場)
   ,0     --通夜利用区分(0:無  1:有)
   ,0      --施設番号-小式場番号(0:指定無  21:式場1  22:式場2  23:式場3) ※23_1011パラメータなし
   ,v_UKETNCD     --受付担当者コード
   ,v_UKETNNM     --受付担当者名
   ,NULL     --窓口区分  2008/05/31
   ,NULL     --備考
   ,p_UKENEND     --年度
---   ,2323
   ,0   --更新SEQ
   ,0    --受付区分 ※23_1011パラメータなし
   ,v_UKEDATE  --受付日付
   ,p_UKECD    --受付番号
   ,p_RSLT     --ステータス(0:正常終了　99:エラー)
   ,p_SQLCODE  --エラーコード
   ,p_SQLERRM   --エラーメッセージ
);
*/
 --受付成功時
    IF P_RSLT = 0 THEN
 --新規
        IF V_NEW = 1 THEN
            INSERT INTO KARI_YOYAKU(
                SID,
                GYO_CD,
                GYO_PASS,
                UKE_NEND,
                UKE_NO,
                UKE_DATETIME
            )VALUES(
                P_SID,
                P_GYOCD,
                P_PASS,
                P_UKENEND,
                P_UKECD,
                V_UKEDATE
            );
 --流用
        ELSE
            UPDATE KARI_YOYAKU
            SET
                UKE_DATETIME = V_UKEDATE
            WHERE
                SID = P_SID
                AND GYO_CD = P_GYOCD
                AND GYO_PASS = P_PASS;
        END IF;
 --予約入力データ準備
        DELETE FROM YOYAKUDATA
        WHERE
            SID = P_SID
            AND UKE_NEND = P_UKENEND
            AND UKE_NO = P_UKECD;
        INSERT INTO YOYAKUDATA(
            SID,
            UKE_NEND,
            UKE_NO
        )VALUES(
            P_SID,
            P_UKENEND,
            P_UKECD
        );
    END IF;
 /*======================================
 例外処理
======================================*/
EXCEPTION
    WHEN OTHERS THEN
        P_UKENEND := NULL;
        P_UKECD := NULL;
        P_RSLT := 99;
        P_SQLCODE := SQLCODE;
        P_SQLERRM := SQLERRM;
END;