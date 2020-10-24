SELECT 
    ProductID,
    CustomerID, 
    AddressID, 
    ShipToAddressID, 
    BillToAddressID, 
    SUM(LineTotal) AS TotalIncome
FROM ProductCustomerAddressesTotal
GROUP BY CUBE 
(
    ProductID,
    CustomerID, 
    AddressID, 
    ShipToAddressID, 
    BillToAddressID
)
ORDER BY TotalIncome DESC 