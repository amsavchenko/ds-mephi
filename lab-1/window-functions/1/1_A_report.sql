-- 1 A
-- Rank your sales persons by number of clients, 
-- report should include rank, sales person id and client number 
-- in descending order.

SELECT 
    RANK() OVER (ORDER BY ClientsNumber DESC) AS Rank,
    SalesPerson,
    ClientsNumber
FROM
(
    SELECT SalesPerson, COUNT(CustomerID) AS ClientsNumber
    FROM SalesLT.Customer
    GROUP BY SalesPerson 
) AS t1