-----------------------------------
---------大本
-----------------------------------

CURSOR C_WK1(V_TYPE VARCHAR2) IS

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

-----------------------------------
--------- 移植
-----------------------------------

CURSOR C_WK1(V_TYPE VARCHAR2) IS

SELECT
    YWK.予約枠番号 AS 式場枠番号
FROM
    (
        SELECT
            'SKJ'      AS 予約種別区分,
            YWKK.予約枠番号
        FROM
            施設予約枠   YWKK,
            施設予約枠名称 YWN
        WHERE
            YWKK.適用開始日 = (
                SELECT
                    MAX(適用開始日)
                FROM
                    施設予約枠
                WHERE
                    適用開始日 <= P_YDATE
            )
            AND YWKK.予約枠名称番号 = YWN.予約枠名称番号
            AND YWKK.名称適用日 = YWN.適用開始日
    )YWK
WHERE
    YWK.予約種別区分 = 'SKJ';