SELECT 
CountryRegion,
ROUND(PERCENT_RANK() OVER(PARTITION BY CountryRegion ORDER BY CustomersNumber DESC), 4) AS PercentRank, 
StateProvince, 
CustomersNumber
FROM
(
    SELECT
    A.CountryRegion,
    A.StateProvince, 
    COUNT(CA.CustomerID) AS CustomersNumber
    FROM 
        SalesLT.CustomerAddress AS CA
        LEFT JOIN
        SalesLT.Address AS A
        ON CA.AddressID = A.AddressID
    GROUP BY A.CountryRegion, A.StateProvince
) AS T1
ORDER BY CountryRegion, CustomersNumber DESC, PercentRank, StateProvince