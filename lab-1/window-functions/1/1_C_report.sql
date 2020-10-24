-- 1 C
-- Rank your sales person by income from sales, 
-- your report should include all sales persons with 
-- id, rank and income in descending order.

SELECT 
RANK() OVER(ORDER BY TotalIncome DESC) AS Rank,
SalesPerson,
Coalesce(TotalIncome, 0) AS TotalIncome
FROM
(     
    SELECT
        C.SalesPerson, 
        SUM(SCPT.LineTotal) AS TotalIncome
    FROM 
        SalesLT.Customer AS C
        LEFT JOIN 
        SalesCustomerProductTotal AS SCPT
        ON C.CustomerID = SCPT.CustomerID 
    GROUP BY C.SalesPerson
) AS t1