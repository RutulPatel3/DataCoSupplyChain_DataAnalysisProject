USE SupplyChain;

SELECT * from DataCoSupplyChainDataset;

CREATE TABLE Customer (
    CustomerId INT PRIMARY KEY,
    CustomerFname NVARCHAR(50),
    CustomerLname NVARCHAR(50),
    CustomerSegment NVARCHAR(50),
    CustomerCity NVARCHAR(50),
    CustomerState NVARCHAR(50),
    CustomerCountry NVARCHAR(50),
    CustomerStreet NVARCHAR(100),
    CustomerZipcode NVARCHAR(20),
    Latitude FLOAT,
    Longitude FLOAT
);

CREATE TABLE Department (
    DepartmentId INT PRIMARY KEY,
    DepartmentName NVARCHAR(50)
);

CREATE TABLE Category (
    CategoryId INT PRIMARY KEY,
    CategoryName NVARCHAR(50),
    DepartmentId INT,
    FOREIGN KEY (DepartmentId) REFERENCES Department(DepartmentId)
);


CREATE TABLE Product (
    ProductCardId INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    ProductCategoryId INT,
    ProductPrice FLOAT,
    ProductStatus NVARCHAR(50),
    FOREIGN KEY (ProductCategoryId) REFERENCES Category(CategoryId)
);


CREATE TABLE Market (
    MarketName NVARCHAR(50) PRIMARY KEY
);


CREATE TABLE Orders (
    OrderId INT PRIMARY KEY,
    OrderCustomerId INT,
    OrderDate DATE,
    OrderRegion NVARCHAR(50),
    OrderCountry NVARCHAR(50),
    OrderState NVARCHAR(50),
    OrderCity NVARCHAR(50),
    OrderStatus NVARCHAR(50),
    ShippingMode NVARCHAR(50),
    ShippingDate DATE,
    Market NVARCHAR(50),
    FOREIGN KEY (OrderCustomerId) REFERENCES Customer(CustomerId),
    FOREIGN KEY (Market) REFERENCES Market(MarketName)
);

CREATE TABLE OrderItem (
    OrderItemId INT PRIMARY KEY,
    OrderId INT,
    ProductCardId INT,
    OrderItemQuantity INT,
    OrderItemProductPrice FLOAT,
    OrderItemDiscount FLOAT,
    OrderItemDiscountRate FLOAT,
    OrderItemProfitRatio FLOAT,
    OrderItemTotal FLOAT,
    Sales FLOAT,
    OrderProfitPerOrder FLOAT,
    FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
    FOREIGN KEY (ProductCardId) REFERENCES Product(ProductCardId)
);

CREATE TABLE Delivery (
    DeliveryId INT PRIMARY KEY,
    OrderId INT,
    DeliveryStatus NVARCHAR(50),
    LateDeliveryRisk BIT,
    DaysForShippingReal INT,
    DaysForShipmentScheduled INT,
    FOREIGN KEY (OrderId) REFERENCES Orders(OrderId)
);





INSERT INTO Customer (
    CustomerId, CustomerFname, CustomerLname, CustomerSegment, CustomerCity,
    CustomerState, CustomerCountry, CustomerStreet, CustomerZipcode, Latitude, Longitude
)
SELECT DISTINCT 
    Customer_Id, Customer_Fname, Customer_Lname, Customer_Segment, Customer_City,
    Customer_State, Customer_Country, Customer_Street, Customer_Zipcode, Latitude, Longitude
FROM DataCoSupplyChainDataset;


INSERT INTO Department (DepartmentId, DepartmentName)
SELECT DISTINCT 
    Department_Id, Department_Name
FROM DataCoSupplyChainDataset;

INSERT INTO Category (CategoryId, CategoryName, DepartmentId)
SELECT DISTINCT 
    Category_Id, Category_Name, Department_Id
FROM DataCoSupplyChainDataset;

INSERT INTO Product (ProductCardId, ProductName, ProductCategoryId, ProductPrice, ProductStatus)
SELECT DISTINCT 
    Product_Card_Id, Product_Name, Product_Category_Id, Product_Price, Product_Status
FROM DataCoSupplyChainDataset;

INSERT INTO Market (MarketName)
SELECT DISTINCT 
    Market
FROM DataCoSupplyChainDataset;


INSERT INTO Orders (
    OrderId, OrderCustomerId, OrderDate, OrderRegion, OrderCountry, OrderState, 
    OrderCity, OrderStatus, ShippingMode, ShippingDate, Market
)
SELECT DISTINCT 
    Order_Id, Order_Customer_Id, Order_Date_DateOrders, Order_Region, Order_Country, Order_State, 
    Order_City, Order_Status, Shipping_Mode, Shipping_Date_DateOrders, Market
FROM DataCoSupplyChainDataset;

INSERT INTO OrderItem (
    OrderItemId, OrderId, ProductCardId, OrderItemQuantity, OrderItemProductPrice, 
    OrderItemDiscount, OrderItemDiscountRate, OrderItemProfitRatio, OrderItemTotal, Sales, 
    OrderProfitPerOrder
)
SELECT DISTINCT 
    Order_Item_Id, Order_Id, Product_Card_Id, Order_Item_Quantity, Order_Item_Product_Price, 
    Order_Item_Discount, Order_Item_Discount_Rate, Order_Item_Profit_Ratio, Order_Item_Total, Sales, 
    Order_Profit_Per_Order
FROM DataCoSupplyChainDataset;

INSERT INTO Delivery (
    DeliveryId, OrderId, DeliveryStatus, LateDeliveryRisk, DaysForShippingReal, DaysForShipmentScheduled
)
SELECT DISTINCT 
    ROW_NUMBER() OVER (ORDER BY Order_Id) AS Delivery_Id, -- Generate unique IDs if missing
    Order_Id, Delivery_Status, Late_Delivery_Risk, Days_For_Shipping_Real, Days_For_Shipment_Scheduled
FROM DataCoSupplyChainDataset;

SELECT COUNT(*) AS TotalRecords, COUNT(DISTINCT order_Id) AS UniqueRecords
FROM DataCoSupplyChainDataset;


SELECT * 
FROM Orders WHERE OrderCustomerId= 256;


