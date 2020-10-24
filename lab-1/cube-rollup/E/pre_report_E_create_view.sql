CREATE VIEW PreReportE AS
SELECT  
    SOH.CustomerID,
    C.SalesPerson,
    SOD.ProductID,
    SOD.OrderQty,
    A.CountryRegion,
    A.StateProvince,
    A.City
FROM 
    SalesLT.SalesOrderDetail SOD, 
    SalesLT.SalesOrderHeader SOH,
    SalesLT.CustomerAddress CA,
    SalesLT.Address A,
    SalesLT.Customer C
WHERE SOD.SalesOrderID = SOH.SalesOrderID AND CA.CustomerID = SOH.CustomerID
AND A.AddressID = CA.AddressID AND C.CustomerID = CA.CustomerID 