 CURSOR c_WK1 IS
    SELECT UKE.業者名
          ,UKE.受付年度
          ,UKE.受付番号
          ,UKE.死亡者姓
          ,UKE.死亡者名
          ,UKE.予約日付
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
          ,DAI.出棺日付 AS 出棺日付台帳 --2015/01/07
          ,DAI.出棺時刻 AS 出棺時刻台帳 --2015/01/07
          ,GYO.受付区分 AS 業者区分     --2015/01/07
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
       
--------------------------------------------------- 追加
         AND (
            (
            UKE.予約枠番号 = YWM.予約枠時刻
            )
            OR
            (
        UKE.予約枠番号 IN (121, 122, 123)
        AND UKE.予約時刻 = 0
            )
    )
--------------------------------------------------- 追加 END

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
        
       AND UKE.死亡者姓 IS NOT NULL --- 追加　変更　23_1205 
  ---     AND YWM.予約時間番号 = YJM.予約時間番号 ---　変更　23_1205 
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
                    YWM.予約枠時刻
                END
               ,UKE.受付番号;
