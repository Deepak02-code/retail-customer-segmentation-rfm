CREATE VIEW rfm_segments AS SELECT 
    CustomerID,
    Frequency,
    Monetary,
    Recency,
    Recency_Score,
    F_Score,
    M_Score,
    CONCAT(Recency_Score, F_Score, M_Score) AS RFM_Score,
    CASE 
        WHEN Recency_Score >= 4 AND F_Score >= 4 AND M_Score >= 4 THEN 'Champions'
        WHEN Recency_Score >= 3 AND F_Score >= 3 THEN 'Loyal Customers'
        WHEN Recency_Score <= 2 AND F_Score >= 3 THEN 'At Risk'
        WHEN Recency_Score >= 4 AND F_Score <= 2 THEN 'New Customers'
        WHEN Recency_Score <= 2 AND F_Score <= 2 THEN 'Lost'
        ELSE 'Needs Attention'
    END AS Segment
FROM (
    SELECT 
        CustomerID,
        Frequency,
        Monetary,
        Recency,
        CASE 
            WHEN Recency <= 30 THEN 5
            WHEN Recency <= 90 THEN 4
            WHEN Recency <= 180 THEN 3
            WHEN Recency <= 300 THEN 2
            ELSE 1
        END AS Recency_Score,
        CASE 
            WHEN Frequency >= 20 THEN 5
            WHEN Frequency >= 15 THEN 4
            WHEN Frequency >= 10 THEN 3
            WHEN Frequency >= 5 THEN 2
            ELSE 1
        END AS F_Score,
        CASE 
            WHEN Monetary >= 20000 THEN 5
            WHEN Monetary >= 10000 THEN 4
            WHEN Monetary >= 5000 THEN 3
            WHEN Monetary >= 2000 THEN 2
            ELSE 1
        END AS M_Score
    FROM (
        SELECT CustomerID,
            COUNT(OrderID) AS Frequency,
            SUM(Sales) AS Monetary,
            DATEDIFF((SELECT MAX(OrderDate) FROM superstore), MAX(OrderDate)) AS Recency
        FROM superstore
        GROUP BY CustomerID
    ) AS rfm_base
) AS rfm_scored;