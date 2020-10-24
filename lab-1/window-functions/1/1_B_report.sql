-- 1 B
-- Rank your sales persons by number of sales, 
-- your report should include all sales persons with id, 
-- dense rank and number of sales in descending order

SELECT 
DENSE_RANK() OVER(ORDER BY SalesNumber DESC) AS DenseRank,
SalesPerson,
SalesNumber
FROM
(
    SELECT
        C.SalesPerson, 
        COUNT(E.OrderQty) AS SalesNumber
    FROM 
        SalesLT.Customer AS C
        LEFT JOIN 
        PreReportE AS E
        ON C.CustomerID = E.CustomerID 
    GROUP BY C.SalesPerson
) AS T1