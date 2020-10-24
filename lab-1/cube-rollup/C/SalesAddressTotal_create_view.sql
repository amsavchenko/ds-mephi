SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SalesAddressTotal] AS
SELECT A.City, A.StateProvince, A.CountryRegion, SAT.LineTotal, SAT.Discount
FROM 
(SELECT ShipToAddressID AS AddressID, LineTotal, Discount FROM SalesCustomerProductTotal) AS SAT
LEFT JOIN
SalesLT.Address AS A
ON SAT.AddressID = A.AddressID

GO
