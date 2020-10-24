CREATE VIEW ParentCatProductCatProductTotal AS
SELECT pc.ParentProductCategoryID, t1.ProductCategoryID, t1.ProductID, t1.LineTotal, t1.Discount
FROM
(
SELECT scpt.ProductID, scpt.LineTotal, scpt.Discount, p.ProductCategoryID
FROM SalesCustomerProductTotal AS scpt, SalesLT.Product AS p
WHERE scpt.ProductID = p.ProductID
) AS t1,
SalesLT.ProductCategory AS pc
WHERE t1.ProductCategoryID = pc.ProductCategoryID