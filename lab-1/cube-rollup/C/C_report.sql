SELECT 
CountryRegion, 
StateProvince, 
City, 
SUM(LineTotal) AS TotalIncome,
SUM(Discount) AS TotalDiscount
FROM SalesAddressTotal 
GROUP BY ROLLUP(CountryRegion, StateProvince, City)
ORDER BY CountryRegion