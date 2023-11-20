-----------------------------------
---------大本
-----------------------------------
SELECT
    NVL(HBYWM.予約枠数, YWM.予約枠数) - NVL(YKT.件数, 0) AS 空数
FROM
    予約枠マスタ  YWM,
    予約時間マスタ YJM,
    (
        SELECT
            予約枠番号,
            予約枠数,
            市外予約上限数
        FROM
            日別予約枠マスタ
        WHERE
            予約日 = '2023-11-10'
    )       HBYWM,
    (
        SELECT
            予約枠番号,
            COUNT(*) AS 件数
        FROM
            予約管理テーブル
        WHERE
            予約日 = '2023-11-10'
            AND ((受付年度 <> NVL(2023, 0))
            OR (受付番号 <> NVL(78, 0)))
        GROUP BY
            予約枠番号
    )       YKT
WHERE
    YWM.予約時間番号 = YJM.予約時間番号
    AND YWM.予約枠番号 = HBYWM.予約枠番号(+)
    AND YWM.予約枠番号 = YKT.予約枠番号(+)
    AND YWM.適用開始日 <= '2023-11-10'
    AND ((YWM.適用終了日 >= '2023-11-10')
    OR (YWM.適用終了日 IS NULL))
    AND YWM.予約枠番号 = 4;

-----------------------------------
--------- 移植
-----------------------------------
SELECT
    NVL(HBYWM.予約枠数, YWM.予約枠数) - NVL(YKT.件数, 0) AS 空数
FROM
    予約枠   YWM,
    予約枠名称 YJM,
    (
        SELECT
            YWN_02.予約枠時刻 AS 予約枠番号,
            HYW.予約枠数     AS 予約枠数,
            HYW.予約枠数     AS 市外予約上限数
        FROM
            日別予約枠 HYW,
            予約枠名称 YWN_02
        WHERE
            HYW.日付 = '2023-11-10'
            AND HYW.KEY1 = 0 --火葬炉枠
            AND HYW.KEY3 = 0 --火葬炉
            AND YWN_02.適用開始日 >= (
                SELECT
                    MAX(適用開始日)
                FROM
                    予約枠名称
                WHERE
                    適用開始日 <= '2023-11-10'
            )
            AND HYW.KEY1 = YWN_02.KEY1
            AND HYW.KEY2 = YWN_02.KEY2
    )     HBYWM,
    (
        SELECT
            予約枠番号,
            COUNT(*) AS 件数
        FROM
            予約管理テーブル
        WHERE
            予約日 = '2023-11-10'
            AND ((受付年度 <> NVL(2023, 0))
            OR (受付番号 <> NVL(78, 0)))
        GROUP BY
            予約枠番号
    )     YKT
WHERE
    YWM.KEY1 = 0
    AND YWM.KEY3 = 0
    AND YWM.適用開始日 = YJM.適用開始日
    AND YJM.予約枠時刻 = HBYWM.予約枠番号(+)
    AND YJM.予約枠時刻 = YKT.予約枠番号(+)
    AND YWM.適用開始日 = (
        SELECT
            MAX(適用開始日)
        FROM
            予約枠
        WHERE
            適用開始日 <= '2023-11-10'
    )
    AND YWM.KEY1 = YJM.KEY1
    AND YWM.KEY2 = YJM.KEY2
    AND YJM.KEY2 = 4;