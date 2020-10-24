CREATE VIEW ProductCustomerAddressesTotal AS
SELECT scpt.*, ca.AddressID 
FROM 
SalesCustomerProductTotal as scpt 
LEFT JOIN 
SalesLT.CustomerAddress as ca
ON scpt.CustomerID = ca.CustomerID
