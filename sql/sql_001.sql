
--------------- 結合して、遅い予約日付のデータを抽出する
SELECT *
FROM 火葬受付 u
INNER JOIN 火葬台帳 t ON u.受付番号 = t.受付番号
WHERE u.受付番号 = 4929 AND t.予約日付 LIKE '24-%'
ORDER BY t.予約日付 DESC
FETCH FIRST 1 ROW ONLY;