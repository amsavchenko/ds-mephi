SELECT 
CountryRegion,
DENSE_RANK() OVER(PARTITION BY CountryRegion ORDER BY CustomersNumber DESC) AS DenseRank, 
StateProvince, 
CustomersNumber
FROM
(
    SELECT 
    A.CountryRegion,
    A.StateProvince,
    COUNT(C.CustomerID) AS CustomersNumber
    FROM 
        SalesLT.Customer AS C
        LEFT JOIN 
        SalesLT.CustomerAddress AS CA
        ON C.CustomerID = CA.CustomerID
        LEFT JOIN
        SalesLT.Address AS A 
        ON CA.AddressID = A.AddressID
    GROUP BY CountryRegion, StateProvince
) AS t1
ORDER BY CountryRegion, CustomersNumber DESC, DenseRank, StateProvince