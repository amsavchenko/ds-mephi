SELECT ProductID, CustomerID, SalesPerson, CountryRegion, StateProvince, City,
SUM(OrderQty) AS TotalQty
FROM PreReportE
GROUP BY 
    CUBE(ProductID, CustomerID, SalesPerson),
    ROLLUP(CountryRegion, StateProvince, City)