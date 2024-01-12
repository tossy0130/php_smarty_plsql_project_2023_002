------------- 年度毎に、受付番号を集計した値を表示
SELECT
    受付年度,
    COUNT(受付番号) AS "火葬数"
FROM
    火葬台帳
GROUP BY
    受付年度
ORDER BY
    受付年度　ASC;