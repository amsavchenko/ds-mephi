CREATE VIEW [dbo].[SalesCustomerProductTotalWith0] AS
SELECT cj.CustomerID, cj.SalesPerson, cj.ProductID, total.LineTotal
FROM CustomerProductCrossJoin AS cj LEFT JOIN SalesCustomerProductTotal AS total 
ON cj.CustomerID = total.CustomerID AND cj.ProductID = total.ProductID