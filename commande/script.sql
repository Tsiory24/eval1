SELECT 
    months.month,
    COALESCE(SUM(p.amount), 0) AS total_amount
FROM 
    (SELECT 1 AS month UNION ALL 
    SELECT 2 UNION ALL 
    SELECT 3 UNION ALL 
    SELECT 4 UNION ALL 
    SELECT 5 UNION ALL 
    SELECT 6 UNION ALL 
    SELECT 7 UNION ALL 
    SELECT 8 UNION ALL 
    SELECT 9 UNION ALL 
    SELECT 10 UNION ALL 
    SELECT 11 UNION ALL 
    SELECT 12) AS months
LEFT JOIN payments p ON MONTH(p.payment_date) = months.month 
AND YEAR(p.payment_date) = 2025 AND deleted at is null
GROUP BY months.month
ORDER BY months.month