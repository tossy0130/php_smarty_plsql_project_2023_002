create or replace PROCEDURE "QUERY_YOYAKUJOKYO"
(  p_SID     IN  VARCHAR2,  --セッションID
   p_GYOCD   IN  NUMBER,    --業者コード
   p_PASS    IN  NUMBER,    --暗証番号
   p_RSLT    OUT NUMBER,    --ステータス(0:正常終了　99:エラー)
   p_SQLCODE OUT NUMBER,    --エラーコード
   p_SQLERRM OUT VARCHAR2   --エラーメッセージ
)
/*******************************************************************************
* 関数名 : QUERY_YOYAKUJOKYO

*******************************************************************************/
/*======================================
  変数宣言
======================================*/
IS
  v_GYO_NO       YOYAKUJOKYOWK.GYO_NO%TYPE;       --行番号
  v_GYOSYA_NAME  YOYAKUJOKYOWK.GYOSYA_NAME%TYPE;  --業者名
  v_UKE_NEND     YOYAKUJOKYOWK.UKE_NEND%TYPE;     --受付年度
  v_UKE_NO       YOYAKUJOKYOWK.UKE_NO%TYPE;       --受付番号
  v_KOJIN_NAME   YOYAKUJOKYOWK.KOJIN_NAME%TYPE;   --死亡者名
  v_YOYAKU_TIME  YOYAKUJOKYOWK.YOYAKU_TIME%TYPE;  --火葬予約日時
  v_MCS_YOYAKU   YOYAKUJOKYOWK.MCS_YOYAKU%TYPE;   --待合室
  v_RKS_YOYAKU   YOYAKUJOKYOWK.RKS_YOYAKU%TYPE;   --霊柩車
  v_SKJ_YOYAKU   YOYAKUJOKYOWK.SKJ_YOYAKU%TYPE;   --式場利用
  v_TYA_YOYAKU   YOYAKUJOKYOWK.TYA_YOYAKU%TYPE;   --通夜式利用
  v_SY7_YOYAKU   YOYAKUJOKYOWK.SY7_YOYAKU%TYPE;   --初七日利用
  v_TANTO_NAME   YOYAKUJOKYOWK.TANTO_NAME%TYPE;   --担当者名
  v_SAIJO_UKEKB  YOYAKUJOKYOWK.SAIJO_UKEKB%TYPE;  --斎場受付区分

  --- 追加 （前橋）夏目 24_0219
  v_MADOGUCHI_UKEKB YOYAKUJOKYOWK.MADOGUCHI_UKEKB%TYPE;  --窓口区分

  v_KOJIN_NAME_TMP   YOYAKUJOKYOWK.KOJIN_NAME%TYPE;   --死亡者名
  v_Loop_FLG NUMBER;

  --- 受付番号 チェック用 --- 追加
  TYPE UKE_NO_LIST_TYPE IS TABLE OF NUMBER;
  v_UKE_NO_LIST UKE_NO_LIST_TYPE := UKE_NO_LIST_TYPE();

  v_SHIKI_TIME 火葬受付.式場時間%TYPE;
  v_SHIKI_KB 火葬受付.式場利用区分%TYPE;
  v_SHIKI_NUM 火葬受付.小式場番号%TYPE;


  --ｶｰｿﾙ宣言
  --予約状況情報

  /*
  CURSOR c_WK1 IS
    SELECT UKE.業者名
          ,UKE.受付年度
          ,UKE.受付番号
          ,UKE.死亡者姓
          ,UKE.死亡者名
          ,UKE.予約日付
          ,YJM.予約時間名
          ,UKE.待合室利用区分
          ,KB1.KBNAME AS 待合室利用区分名
          ,UKE.霊きゅう車利用区分
          ,KB2.KBNAME AS 霊柩車利用区分名
          ,UKE.霊柩車開始日区分
          ,KB3.KBNAME AS 霊柩車開始日区分名
          ,UKE.霊柩車出棺時刻
          ,UKE.式場利用区分
          ,KB4.KBNAME AS 式場利用区分名
          ,UKE.告別式開始日区分
          ,KB5.KBNAME AS 告別式開始日区分名
          ,UKE.告別式開始時刻
          ,UKE.通夜利用区分
          ,KB6.KBNAME AS 通夜利用区分名
          ,UKE.通夜式開始日区分
          ,KB7.KBNAME AS 通夜式開始日区分名
          ,UKE.通夜式開始時刻
          ,UKE.初七日利用区分
          ,KB8.KBNAME AS 初七日利用区分名
          ,UKE.初七日開始日区分
          ,KB9.KBNAME AS 初七日開始日区分名
          ,UKE.初七日開始時刻
--        ,ABM.担当識別名
          ,DECODE(GYO.受付区分, 2, GYS.業者略称, 9, GYS.業者略称, ABM.担当識別名) AS 担当識別名 --2014/09/16
          ,UKE.受付区分
          ,DAI.死亡者姓 AS 死亡者姓台帳
          ,DAI.死亡者名 AS 死亡者名台帳
          ,DAI.出棺日付 AS 出棺日付台帳 --2015/01/07
          ,DAI.出棺時刻 AS 出棺時刻台帳 --2015/01/07
          ,GYO.受付区分 AS 業者区分     --2015/01/07
      FROM 火葬受付 UKE
          ,火葬台帳 DAI
          ,予約枠マスタ YWM
          ,予約時間マスタ YJM
          ,(SELECT KBCODE, KBNAME FROM KBNF WHERE KBTYPE = '待合室利用区分') KB1
          ,(SELECT KBCODE, KBNAME FROM KBNF WHERE KBTYPE = '霊柩車利用区分') KB2
          ,(SELECT KBCODE, KBNAME FROM KBNF WHERE KBTYPE = '開始日区分') KB3
          ,(SELECT KBCODE, KBNAME FROM KBNF WHERE KBTYPE = '式場利用区分') KB4
          ,(SELECT KBCODE, KBNAME FROM KBNF WHERE KBTYPE = '開始日区分') KB5
          ,(SELECT KBCODE, KBNAME FROM KBNF WHERE KBTYPE = '式場利用区分') KB6
          ,(SELECT KBCODE, KBNAME FROM KBNF WHERE KBTYPE = '開始日区分') KB7
          ,(SELECT KBCODE, KBNAME FROM KBNF WHERE KBTYPE = '式場利用区分') KB8
          ,(SELECT KBCODE, KBNAME FROM KBNF WHERE KBTYPE = '開始日区分') KB9
          ,暗証番号 ABM
--2014/09/16 Start
          ,業者  GYS
          ,(SELECT 受付区分, 業者コード  FROM 業者 WHERE 業者コード = p_GYOCD) GYO
     WHERE ((GYO.受付区分 = 9) OR
            (GYO.受付区分 = 0 AND GYO.業者コード = UKE.業者コード) OR
            (GYO.受付区分 = 1 AND GYO.業者コード = UKE.業者コード) OR
            (GYO.受付区分 = 2 AND UKE.霊きゅう車利用区分 <> 0))
--2014/09/16 End
       AND UKE.整理番号 = DAI.整理番号(+)
       AND DAI.火葬執行番号 IS NULL
       AND UKE.予約枠番号 = YWM.予約枠番号
       AND YWM.予約時間番号 = YJM.予約時間番号
       AND UKE.待合室利用区分     = KB1.KBCODE(+)
       AND UKE.霊きゅう車利用区分 = KB2.KBCODE(+)
       AND UKE.霊柩車開始日区分   = KB3.KBCODE(+)
       AND UKE.式場利用区分       = KB4.KBCODE(+)
       AND UKE.告別式開始日区分   = KB5.KBCODE(+)
       AND UKE.通夜利用区分       = KB6.KBCODE(+)
       AND UKE.通夜式開始日区分   = KB7.KBCODE(+)
       AND UKE.初七日利用区分     = KB8.KBCODE(+)
       AND UKE.初七日開始日区分   = KB9.KBCODE(+)
       AND UKE.業者コード = GYS.業者コード(+) --2014/09/06
       AND UKE.業者コード = ABM.業者コード(+)
       AND UKE.暗証番号   = ABM.暗証番号(+)
       AND UKE.受付区分 <> 9
--2014/09/16   AND UKE.業者コード = p_GYOCD
       AND (UKE.受付年度, UKE.受付番号) NOT IN (SELECT UKE_NEND, UKE_NO FROM KARI_YOYAKU)
       AND (NVL(DAI.火葬区分, -1) < 3) --2015/02/13 未確定及び大人・小人・死産児のみ
 --    AND UKE.予約日付 > (SYSDATE - 1) --2014/08/21 過去予約非表示(仮対応)
 --    ORDER BY UKE.予約日付, YJM.表示並び順, UKE.受付番号;
--2015/01/07     ORDER BY UKE.受付日時 DESC, YJM.表示並び順, UKE.受付番号; --2014/09/03
--2015/01/07 ここから
       ORDER BY CASE
                  WHEN GYO.受付区分 = 9 THEN --管理者
                    UKE.予約日付
                  WHEN GYO.受付区分 = 2 THEN --配車業者
                    CASE
                      WHEN UKE.受付区分 = 1 THEN --確定済み
                        DAI.出棺日付
                      ELSE                       --仮予約
                        NVL2(UKE.霊柩車開始日区分, UKE.予約日付 + UKE.霊柩車開始日区分, UKE.予約日付 - 1)
                    END
                  ELSE
                    NULL
                END
               ,CASE
                  WHEN ((GYO.受付区分 = 9) OR (GYO.受付区分 = 2)) THEN --管理者、配車業者
                    NULL
                  ELSE
                    UKE.受付日時
                END DESC
               ,CASE
                  WHEN GYO.受付区分 = 2 THEN --配車業者
                    CASE
                      WHEN UKE.受付区分 = 1 THEN --確定済み
                        DAI.出棺時刻
                      ELSE                       --仮予約
                        NVL2(UKE.霊柩車出棺時刻,CVT_TIMENUM(UKE.霊柩車出棺時刻),9999)
                    END
                  ELSE
                    YJM.表示並び順
                END
               ,UKE.受付番号;

*/

---- ============================
  CURSOR c_WK1 IS
    SELECT UKE.業者名
          ,UKE.受付年度
          ,UKE.受付番号
          ,UKE.死亡者姓
          ,UKE.死亡者名
          ,UKE.予約日付
          ,UKE.式場時間 --- 追加
          ,UKE.小式場番号 --- 追加
        --  ,YJM.予約時間名  --- 変更
          ,YWM.予約枠名  --- 追加
          ,UKE.待合室利用区分
          ,KB1.KBNAME AS 待合室利用区分名
          ,UKE.霊きゅう車利用区分
          ,KB2.KBNAME AS 霊柩車利用区分名
          ,UKE.霊柩車開始日区分
          ,KB3.KBNAME AS 霊柩車開始日区分名
          ,UKE.霊柩車出棺時刻
          ,UKE.式場利用区分
          ,KB4.KBNAME AS 式場利用区分名
          ,UKE.告別式開始日区分
          ,KB5.KBNAME AS 告別式開始日区分名
          ,UKE.告別式開始時刻
          ,UKE.通夜利用区分
          ,KB6.KBNAME AS 通夜利用区分名
          ,UKE.通夜式開始日区分
          ,KB7.KBNAME AS 通夜式開始日区分名
          ,UKE.通夜式開始時刻
          ,UKE.初七日利用区分
          ,KB8.KBNAME AS 初七日利用区分名
          ,UKE.初七日開始日区分
          ,KB9.KBNAME AS 初七日開始日区分名
          ,UKE.初七日開始時刻
--        ,ABM.担当識別名
          ,DECODE(GYO.受付区分, 2, GYS.業者略称, 9, GYS.業者略称, ABM.担当識別名) AS 担当識別名 --2014/09/16
          ,UKE.受付区分
          ,DAI.死亡者姓 AS 死亡者姓台帳
          ,DAI.死亡者名 AS 死亡者名台帳
    --      ,DAI.出棺日付 AS 出棺日付台帳 --2015/01/07
          ,DAI.出棺時刻 AS 出棺時刻台帳 --2015/01/07
          ,GYO.受付区分 AS 業者区分     --2015/01/07
          ,UKE.窓口区分 AS 窓口区分 ------ 追加 24_0219 夏目
      FROM 火葬受付 UKE
          ,火葬台帳 DAI
          ,予約枠名称 YWM
          ,予約枠 YYW
          ,(SELECT KBCODE, KBNAME FROM KBNF WHERE KBTYPE = '待合室利用区分') KB1
          ,(SELECT KBCODE, KBNAME FROM KBNF WHERE KBTYPE = '霊柩車利用区分') KB2
          ,(SELECT KBCODE, KBNAME FROM KBNF WHERE KBTYPE = '開始日区分') KB3
          ,(SELECT KBCODE, KBNAME FROM KBNF WHERE KBTYPE = '式場利用区分') KB4
          ,(SELECT KBCODE, KBNAME FROM KBNF WHERE KBTYPE = '開始日区分') KB5
          ,(SELECT KBCODE, KBNAME FROM KBNF WHERE KBTYPE = '式場利用区分') KB6
          ,(SELECT KBCODE, KBNAME FROM KBNF WHERE KBTYPE = '開始日区分') KB7
          ,(SELECT KBCODE, KBNAME FROM KBNF WHERE KBTYPE = '式場利用区分') KB8
          ,(SELECT KBCODE, KBNAME FROM KBNF WHERE KBTYPE = '開始日区分') KB9
          ,暗証番号 ABM
--2014/09/16 Start
          ,業者  GYS
          ,(SELECT 受付区分, 業者コード  FROM 業者 WHERE 業者コード = p_GYOCD) GYO

     WHERE ((GYO.受付区分 = 9) OR
            (GYO.受付区分 = 0 AND GYO.業者コード = UKE.業者コード) OR
            (GYO.受付区分 = 1 AND GYO.業者コード = UKE.業者コード) OR
            (GYO.受付区分 = 2 AND UKE.霊きゅう車利用区分 <> 0))
--2014/09/16 End
       AND UKE.整理番号 = DAI.整理番号(+)
       AND DAI.火葬執行番号 IS NULL

         AND (
            (
            UKE.予約枠番号 = YWM.予約枠時刻
            )
            OR
            (
        UKE.予約枠番号 IN (120,121,122,123,220,221,222,223,320)
        AND UKE.予約時刻 = 0
            )
    )

       AND YWM.適用開始日 = (
                SELECT
                    MAX(適用開始日)
                FROM
                    予約枠
                WHERE
                    適用開始日 < SYSDATE
            )
        AND YWM.KEY2 = YYW.KEY2 --- 追加　変更　23_1205
        AND YYW.KEY3 = 0 --- 追加　変更　23_1205
        AND YYW.適用開始日 = ( --- 追加　変更　23_1205
                SELECT
                    MAX(適用開始日)
                FROM
                    予約枠
                WHERE
                    適用開始日 < SYSDATE
            )


       AND UKE.待合室利用区分     = KB1.KBCODE(+)
       AND UKE.霊きゅう車利用区分 = KB2.KBCODE(+)
       AND UKE.霊柩車開始日区分   = KB3.KBCODE(+)
       AND UKE.式場利用区分       = KB4.KBCODE(+)
       AND UKE.告別式開始日区分   = KB5.KBCODE(+)
       AND UKE.通夜利用区分       = KB6.KBCODE(+)
       AND UKE.通夜式開始日区分   = KB7.KBCODE(+)
       AND UKE.初七日利用区分     = KB8.KBCODE(+)
       AND UKE.初七日開始日区分   = KB9.KBCODE(+)
       AND UKE.業者コード = GYS.業者コード(+) --2014/09/06
       AND UKE.業者コード = ABM.業者コード(+)
       AND UKE.暗証番号   = ABM.暗証番号(+)
       AND UKE.受付区分 <> 9
--2014/09/16   AND UKE.業者コード = p_GYOCD
       AND (UKE.受付年度, UKE.受付番号) NOT IN (SELECT UKE_NEND, UKE_NO FROM KARI_YOYAKU)
  ---     AND (NVL(DAI.火葬区分, -1) < 3) --2015/02/13 未確定及び大人・小人・死産児のみ
       AND UKE.予約日付 >= SYSDATE   --- 追加　夏目
       AND UKE.火葬区分 in (0, 1, 2) --- 追加　夏目
       AND UKE.窓口区分 in (0, 3, 4) --- 追加　夏目

       ORDER BY CASE
                  WHEN GYO.受付区分 = 9 THEN --管理者
                    UKE.予約日付
                  ELSE
                    NULL
                END
               ,CASE
                  WHEN ((GYO.受付区分 = 9) OR (GYO.受付区分 = 2)) THEN --管理者、配車業者
                    NULL
                  ELSE
                    UKE.受付日時
                END DESC
               ,CASE
                  WHEN GYO.受付区分 = 2 THEN --配車業者
                    CASE
                      WHEN UKE.受付区分 = 1 THEN --確定済み
                        DAI.出棺時刻
                      ELSE                       --仮予約
                        NVL2(UKE.霊柩車出棺時刻,CVT_TIMENUM(UKE.霊柩車出棺時刻),9999)
                    END
                END
               ,UKE.受付番号;


--2015/01/07 ここまで
  ---ﾚｺｰﾄﾞ宣言
  r_WK1 c_WK1%ROWTYPE;

/*======================================
  本体
======================================*/
BEGIN
  --初期処理
  p_RSLT := 0;
  p_SQLCODE := 0;
  p_SQLERRM := NULL;

  v_Loop_FLG := 0;


  --予約状況クリア
  DELETE FROM YOYAKUJOKYOWK WHERE SID = p_SID;
  --仮押さえキャンセル
  YOYAKU_CANCEL(p_SID, p_GYOCD, p_PASS, p_RSLT, p_SQLCODE, p_SQLERRM);
  v_GYO_NO := 0;  --行番号
  --予約状況情報取得ループ
  FOR r_WK1 IN c_WK1 LOOP

    --受付番号
    v_UKE_NO       := r_WK1.受付番号;

    ------------------------------------------- 追記 12_25 夏目
    -- 重複チェック
    IF v_UKE_NO MEMBER OF v_UKE_NO_LIST THEN
        -- 重複した場合はスキップ
        CONTINUE;
    ELSE
        -- 重複していない場合はリストに追加
        v_UKE_NO_LIST.EXTEND;
        v_UKE_NO_LIST(v_UKE_NO_LIST.LAST) := v_UKE_NO;
    END IF;
    ------------------------------------------- 追記 12_25 夏目 END

      --行番号
    v_GYO_NO       := v_GYO_NO + 1;
    --業者名
    v_GYOSYA_NAME  := r_WK1.業者名;
    --受付年度
    v_UKE_NEND     := r_WK1.受付年度;

    v_SHIKI_TIME := r_WK1.式場時間;
    DBMS_OUTPUT.PUT_LINE(v_SHIKI_TIME);
    v_SHIKI_KB := r_WK1.式場利用区分;
    DBMS_OUTPUT.PUT_LINE(v_SHIKI_KB);
    v_SHIKI_NUM := r_WK1.小式場番号;
    DBMS_OUTPUT.PUT_LINE(v_SHIKI_NUM);

    --死亡者名
--2014/09/03
--  IF (r_WK1.死亡者姓 IS NOT NULL) OR (r_WK1.死亡者名 IS NOT NULL) THEN
--    v_KOJIN_NAME   := r_WK1.死亡者姓 || ' ' || r_WK1.死亡者名;
    IF (r_WK1.死亡者姓 IS NOT NULL)THEN
      v_KOJIN_NAME   := r_WK1.受付番号 || ':' || r_WK1.死亡者姓 || r_WK1.死亡者名;
--  ELSIF (r_WK1.死亡者姓台帳 IS NOT NULL) OR (r_WK1.死亡者名台帳 IS NOT NULL) THEN
--    v_KOJIN_NAME   := r_WK1.死亡者姓台帳 || ' ' || r_WK1.死亡者名台帳;
    ELSIF (r_WK1.死亡者姓台帳 IS NOT NULL)THEN
      v_KOJIN_NAME   := r_WK1.受付番号 || ':' || r_WK1.死亡者姓台帳 || r_WK1.死亡者名台帳 ;
    ELSE
      v_KOJIN_NAME   := r_WK1.受付番号;
    END IF;
    --火葬予約日時


 --- 追加 23_1205 夏目
 --   v_YOYAKU_TIME  := TO_CHAR(r_WK1.予約日付, 'MM"月"DD"日""("DY")"') || ' ' || r_WK1.予約時間名;
    IF v_SHIKI_KB <> 0 THEN

        IF v_SHIKI_TIME = 1 THEN
             v_YOYAKU_TIME  := TO_CHAR(r_WK1.予約日付, 'MM"月"DD"日""("DY")"') || ' ' || '午前';
        ELSIF v_SHIKI_TIME = 2 THEN
             v_YOYAKU_TIME  := TO_CHAR(r_WK1.予約日付, 'MM"月"DD"日""("DY")"') || ' ' || '午後';
        ELSIF v_SHIKI_TIME = 3 THEN
             v_YOYAKU_TIME  := TO_CHAR(r_WK1.予約日付, 'MM"月"DD"日""("DY")"') || ' ' || '全日';
        END IF;

    ELSE
        v_YOYAKU_TIME  := TO_CHAR(r_WK1.予約日付, 'MM"月"DD"日""("DY")"') || ' ' || r_WK1.予約枠名;
    END IF;
 --- 追加 23_1205 夏目 END

    --待合室
    v_MCS_YOYAKU   := r_WK1.待合室利用区分名;
    --霊柩車
--2015/01/07 ここから
--    v_RKS_YOYAKU   := r_WK1.霊柩車利用区分名;
--    IF r_WK1.霊きゅう車利用区分 <> 0 THEN
--      IF r_WK1.霊柩車開始日区分名 IS NOT NULL THEN
--        v_RKS_YOYAKU := v_RKS_YOYAKU || ' ' || r_WK1.霊柩車開始日区分名;
--      END IF;
--      IF r_WK1.霊柩車出棺時刻 IS NOT NULL THEN
--        v_RKS_YOYAKU := v_RKS_YOYAKU || ' ' || r_WK1.霊柩車出棺時刻;
--      END IF;
--    END IF;
    IF r_WK1.業者区分 = 2 THEN --配車業者の場合
      v_RKS_YOYAKU   := r_WK1.霊柩車利用区分名;
      IF r_WK1.霊きゅう車利用区分 <> 0 THEN
        IF r_WK1.受付区分 = 1 THEN --確定済み

          /*
          IF r_WK1.出棺日付台帳 IS NOT NULL THEN
            v_RKS_YOYAKU := v_RKS_YOYAKU || ' ' || TO_CHAR(r_WK1.出棺日付台帳, 'DD"日"');
          END IF;
          */

          IF r_WK1.出棺時刻台帳 IS NOT NULL THEN
            v_RKS_YOYAKU := v_RKS_YOYAKU || ' ' || CVT_TIMESTR(r_WK1.出棺時刻台帳);
          END IF;
        ELSE --仮予約
          IF r_WK1.霊柩車開始日区分 IS NOT NULL THEN
            v_RKS_YOYAKU := v_RKS_YOYAKU || ' ' || TO_CHAR(r_WK1.予約日付 + r_WK1.霊柩車開始日区分, 'DD"日"');
          END IF;
          IF r_WK1.霊柩車出棺時刻 IS NOT NULL THEN
            v_RKS_YOYAKU := v_RKS_YOYAKU || ' ' || r_WK1.霊柩車出棺時刻;
          END IF;
        END IF;
      END IF;
    ELSE
      v_RKS_YOYAKU   := r_WK1.霊柩車利用区分名;
      IF r_WK1.霊きゅう車利用区分 <> 0 THEN
        IF r_WK1.霊柩車開始日区分名 IS NOT NULL THEN
          v_RKS_YOYAKU := v_RKS_YOYAKU || ' ' || r_WK1.霊柩車開始日区分名;
        END IF;
        IF r_WK1.霊柩車出棺時刻 IS NOT NULL THEN
          v_RKS_YOYAKU := v_RKS_YOYAKU || ' ' || r_WK1.霊柩車出棺時刻;
        END IF;
      END IF;
    END IF;
--2015/01/07 ここまで
    --式場利用
    v_SKJ_YOYAKU   := r_WK1.式場利用区分名;
    IF r_WK1.式場利用区分 <> 0 THEN
      IF r_WK1.告別式開始日区分名 IS NOT NULL AND r_WK1.告別式開始時刻 IS NOT NULL     THEN
        v_SKJ_YOYAKU := r_WK1.告別式開始日区分名 || ' ' || r_WK1.告別式開始時刻;
      END IF;
    END IF;
    --通夜式利用
    v_TYA_YOYAKU   := r_WK1.通夜利用区分名;
    IF r_WK1.通夜利用区分 <> 0 THEN
      IF r_WK1.通夜式開始日区分名 IS NOT NULL AND r_WK1.通夜式開始時刻 IS NOT NULL THEN
        v_TYA_YOYAKU := r_WK1.通夜式開始日区分名 || ' ' || r_WK1.通夜式開始時刻;
      END IF;
    END IF;
    --初七日利用
    v_SY7_YOYAKU   := r_WK1.初七日利用区分名;
    IF r_WK1.初七日利用区分 <> 0 THEN
      IF r_WK1.初七日開始日区分名 IS NOT NULL AND r_WK1.初七日開始時刻 IS NOT NULL THEN
        v_SY7_YOYAKU := r_WK1.初七日開始日区分 || ' ' || r_WK1.初七日開始時刻;
      END IF;
    END IF;
    --担当者名
    v_TANTO_NAME   := r_WK1.担当識別名;
    --斎場受付区分
    v_SAIJO_UKEKB  := r_WK1.受付区分;

    --------- 追加（前橋） 夏目 24_0219
    v_MADOGUCHI_UKEKB := r_WK1.窓口区分;

    --データ挿入
    INSERT INTO YOYAKUJOKYOWK(
      SID
     ,GYO_NO       --行番号
     ,GYOSYA_NAME  --業者名
     ,UKE_NEND     --受付年度
     ,UKE_NO       --受付番号
     ,KOJIN_NAME   --死亡者名
     ,YOYAKU_TIME  --火葬予約日時
     ,MCS_YOYAKU   --待合室
     ,RKS_YOYAKU   --霊柩車
     ,SKJ_YOYAKU   --式場利用
     ,TYA_YOYAKU   --通夜式利用
     ,SY7_YOYAKU   --初七日利用
     ,TANTO_NAME   --担当者名
     ,SAIJO_UKEKB  --斎場受付区分
     ,MADOGUCHI_UKEKB -- 窓口区分 --- 追加　夏目（前橋） 24_0219
    )VALUES(
      p_SID
     ,v_GYO_NO       --行番号
     ,v_GYOSYA_NAME  --業者名
     ,v_UKE_NEND     --受付年度
     ,v_UKE_NO       --受付番号
     ,v_KOJIN_NAME   --死亡者名
     ,v_YOYAKU_TIME  --火葬予約日時
     ,v_MCS_YOYAKU   --待合室
     ,v_RKS_YOYAKU   --霊柩車
     ,v_SKJ_YOYAKU   --式場利用
     ,v_TYA_YOYAKU   --通夜式利用
     ,v_SY7_YOYAKU   --初七日利用
     ,v_TANTO_NAME   --担当者名
     ,v_SAIJO_UKEKB  --斎場受付区分
     ,v_MADOGUCHI_UKEKB -- 窓口区分 --- 追加　夏目（前橋） 24_0219
    );
  END LOOP;
/*======================================
 例外処理
======================================*/
EXCEPTION
  WHEN OTHERS THEN
    p_RSLT    := 99;
    p_SQLCODE := SQLCODE;
    p_SQLERRM := SQLERRM;
END;