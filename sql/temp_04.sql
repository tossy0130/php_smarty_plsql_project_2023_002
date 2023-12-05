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
            適用開始日 <= TO_DATE('2023-11-28', 'YYYY-mm-dd')
    )
    AND 予約枠.KEY2 = 予約枠名称.KEY2
    AND 予約枠.KEY3 = 0
    AND 予約枠.適用開始日 = 予約枠名称.適用開始日;

----- 予約日からの、最新の適用開始日のデータを取得（日付のところには、予約日が入る）
SELECT
    KEY2
FROM
    予約枠
WHERE
    適用開始日 = (
        SELECT
            MAX(適用開始日)
        FROM
            予約枠
        WHERE
            適用開始日 <= TO_DATE('2023-11-28', 'YYYY-mm-dd')
    )
    AND KEY3 = 0;

-----------------------------------------------------
SELECT
    予約枠名  AS 予約時間名,
    予約枠時刻 AS 予約時間番号
FROM
    予約枠名称
WHERE
    KEY1 = 0
    AND 適用開始日 >= (
        SELECT
            MAX(適用開始日)
        FROM
            予約枠
        WHERE
            適用開始日 <= '2023-11-27'
    )
    AND 適用開始日 <= (
        SELECT
            MAX(適用開始日)
        FROM
            予約枠
        WHERE
            適用開始日 <= '2023-11-27'
    )
GROUP BY
    予約枠名,
    予約枠時刻
ORDER BY
    予約時間名 ASC;

-----------------------------------------------------
SELECT
    YWM.*
FROM
    予約枠名称 YWM
WHERE
    YWM.予約枠時刻 = 1100
    AND YWM.適用開始日 >= (
        SELECT
            MAX(適用開始日)
        FROM
            予約枠
        WHERE
            適用開始日 <= '2023-11-27'
    );

------------------------------------------------------

SELECT
    *
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
            適用開始日 <= '2023-11-28'
    )
    AND YWK.適用開始日 = YWN.適用開始日
    AND YWK.KEY1 = YWN.KEY1
    AND YWK.KEY2 = YWN.KEY2
    AND YWN.予約枠時刻 = 1100;