USE DataCoSupplyChainDataset;

SELECT * from DataCoSupplyChainDataset;

-- Removing unnecessory columns

--customer email, customer password, order zipcode product description and product image

ALTER TABLE DataCoSupplyChainDataset DROP COLUMN Customer_Email, Customer_Password, Order_Zipcode, Product_Description, Product_Image;

SELECT * from DataCoSupplyChainDataset;


SELECT * from DataCoSupplyChainDataset WHERE Latitude IS NULL;
SELECT * from DataCoSupplyChainDataset WHERE Longitude IS NULL;
