USE SupplyChainDataset;

SELECT * from DataCoSupplyChainDataset;

-- Removing unnecessory columns

--customer email, customer password, order zipcode product description and product image

ALTER TABLE DataCoSupplyChainDataset DROP COLUMN Customer_Email, Customer_Password, Order_Zipcode, Product_Description, Product_Image;

SELECT * from DataCoSupplyChainDataset;

