SELECT CustomerID, SalesPerson, ProductID, SUM(LineTotal) as TotalIncome
FROM SalesCustomerProductTotalWith0
GROUP BY CUBE(CustomerID, SalesPerson, ProductID)
ORDER BY ProductID