SELECT 
ParentProductCategoryID,
ProductCategoryID,
ProductID,
SUM(LineTotal) AS TotalIncome,
SUM(Discount) AS TotalDiscount
FROM ParentCatProductCatProductTotal
GROUP BY ROLLUP 
(
    ParentProductCategoryID,
    ProductCategoryID,
    ProductID
)