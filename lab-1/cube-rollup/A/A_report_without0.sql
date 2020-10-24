SELECT CustomerID, SalesPerson, ProductID, SUM(LineTotal) as TotalIncome
FROM SalesCustomerProductTotal
GROUP BY CUBE(CustomerID, SalesPerson, ProductID)
ORDER BY SalesPerson