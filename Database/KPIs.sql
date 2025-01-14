USE DataCoSupplyChainDataset;
--Total Sales

SELECT SUM(Sales_per_customer) as TOTAL_SALES FROM DataCoSupplyChainDataset;
-- Total Orders
SELECT SUM(Order_Item_Quantity) as TOTAL_ORDERS FROM DataCoSupplyChainDataset; 
--Profit Margin
SELECT ((SUM(Benefit_per_order)/SUM(Sales_per_customer))*100) as PROFIT_MARGIN FROM DataCoSupplyChainDataset;

-- Late Delivery Risk 
WITH TotalOrders AS (
	SELECT COUNT(Late_delivery_risk) AS total_orders FROM DataCoSupplyChainDataset

),
LateRiskOrders AS(
	SELECT COUNT(Late_delivery_risk) AS late_risk_orders FROM DataCoSupplyChainDataset WHERE Late_delivery_risk = 1
) 

SELECT (((CAST(LateRiskOrders.late_risk_orders AS FLOAT))/ (TotalOrders.total_orders))*100) AS LateRiskOrdersPercentage FROM TotalOrders, LateRiskOrders


-- Top Performing Product Category

SELECT TOP 5 Category_Name, SUM(Sales_per_customer) AS Sales_per_category 
FROM DataCoSupplyChainDataset 
GROUP BY Category_Name 
ORDER BY SUM(Sales_per_customer) DESC ;



