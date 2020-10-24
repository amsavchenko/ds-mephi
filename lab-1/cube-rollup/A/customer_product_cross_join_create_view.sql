CREATE VIEW CustomerProductCrossJoin AS
SELECT C.CustomerID, C.SalesPerson, P.ProductID
FROM SalesLT.Customer as C CROSS JOIN SalesLT.Product as P