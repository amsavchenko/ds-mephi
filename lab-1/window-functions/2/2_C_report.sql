SELECT 
CountryRegion,
StateProvince,
City,
CustomersNumber,
RANK() OVER(PARTITION BY CountryRegion ORDER BY CustomersNumber DESC, City) AS Rank,
(CustomersNumber - LAG(CustomersNumber) OVER(PARTITION BY CountryRegion ORDER BY CustomersNumber DESC, City)) AS LAGCustomersNumber
FROM
(
    SELECT
    A.CountryRegion,
    A.StateProvince, 
    A.City,
    COUNT(CA.CustomerID) AS CustomersNumber
    FROM 
        SalesLT.CustomerAddress AS CA
        LEFT JOIN
        SalesLT.Address AS A
        ON CA.AddressID = A.AddressID
    GROUP BY A.CountryRegion, A.StateProvince, A.City
) AS T1
ORDER BY CountryRegion, Rank, CustomersNumber DESC
