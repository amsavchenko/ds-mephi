CREATE VIEW [dbo].[SalesCustomerProductTotal] AS
SELECT t1.*, t2.SalesPerson
FROM SalesLT.Customer as t2,
(
    SELECT 
        SOD.ProductID, 
        SOD.LineTotal,
        SOD.OrderQty * SOD.UnitPrice * SOD.UnitPriceDiscount AS Discount, 
        SOH.CustomerID, 
        SOH.ShipToAddressID,
        SOH.BillToAddressID
    FROM 
        SalesLT.SalesOrderDetail SOD, 
        SalesLT.SalesOrderHeader SOH 
    WHERE SOD.SalesOrderID = SOH.SalesOrderID
) AS t1
WHERE t1.CustomerID = t2.CustomerID