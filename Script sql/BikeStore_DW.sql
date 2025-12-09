---------------------------------------------------------
-- CREAR BASE DE DATOS
---------------------------------------------------------
CREATE DATABASE BikeStore_DW;
GO

USE BikeStore_DW;
GO

---------------------------------------------------------
-- TABLA DE CONTROL DE CARGAS
---------------------------------------------------------
CREATE TABLE cargarFTSales(
    CargaKey INT IDENTITY(1,1) NOT NULL,
    UltimaCarga DATETIME,
    CONSTRAINT PK_CargaFTSales PRIMARY KEY (CargaKey)
);

INSERT INTO cargarFTSales (UltimaCarga)
VALUES (GETDATE());

SELECT * FROM cargarFTSales;
GO

---------------------------------------------------------
-- DIMENSIONES
---------------------------------------------------------

---------------------------------------------------------
-- DIM CUSTOMERS
---------------------------------------------------------
CREATE TABLE dbo.DimCustomers(
    CustomerKey INT IDENTITY(1,1) NOT NULL,
    CustomerID INT NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    City VARCHAR(50) NULL,
    State VARCHAR(25) NULL,
    ZipCode VARCHAR(5) NULL,
    CONSTRAINT PK_DimCustomer PRIMARY KEY(CustomerKey)
);
GO

---------------------------------------------------------
-- DIM CUSTOMERS_HIST: Tipo SDC2
---------------------------------------------------------
CREATE TABLE dbo.DimCustomers_Hist(
    CustomerKey INT IDENTITY(1,1) NOT NULL,
    CustomerID INT NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    City VARCHAR(50) NULL,
    State VARCHAR(25) NULL,
    ZipCode VARCHAR(5) NULL,
    StartDate datetime,
	EndDate datetime
);
GO

---------------------------------------------------------
-- DIM PRODUCTS
---------------------------------------------------------
CREATE TABLE dbo.DimProducts(
    ProductKey INT IDENTITY(1,1) NOT NULL,
    ProductID INT NOT NULL,
    ProductName VARCHAR(255) NOT NULL,
    BrandID INT NOT NULL,
    BrandName VARCHAR(255) NOT NULL,
    CategoryID INT NOT NULL,
    CategoryName VARCHAR(255) NOT NULL,
    ModelYear SMALLINT NOT NULL,
    ListPrice DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_DimProduct PRIMARY KEY(ProductKey)
);
GO

---------------------------------------------------------
-- DIM PRODUCTS_HIST: Tipo SDC2
---------------------------------------------------------
CREATE TABLE dbo.DimProducts_Hist(
    ProductKey INT IDENTITY(1,1) NOT NULL,
    ProductID INT NOT NULL,
    ProductName VARCHAR(255) NOT NULL,
    BrandID INT NOT NULL,
    BrandName VARCHAR(255) NOT NULL,
    CategoryID INT NOT NULL,
    CategoryName VARCHAR(255) NOT NULL,
    ModelYear SMALLINT NOT NULL,
    ListPrice DECIMAL(10,2) NOT NULL,
	StartDate datetime,
	EndDate datetime
);
GO

---------------------------------------------------------
-- DIM STORES
---------------------------------------------------------
CREATE TABLE dbo.DimStores(
    StoreKey INT IDENTITY(1,1) NOT NULL,
    StoreID INT NOT NULL,
    StoreName VARCHAR(255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255),
	street VARCHAR (255),
    City VARCHAR(255) NULL,
    State VARCHAR(25) NULL,
    ZipCode VARCHAR(5) NULL,
    CONSTRAINT PK_DimStore PRIMARY KEY(StoreKey)
);
GO

---------------------------------------------------------
-- DIM STAFFS (empleados)
---------------------------------------------------------
CREATE TABLE dbo.DimStaffs(
    StaffKey INT IDENTITY(1,1) NOT NULL,
    StaffID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(255) NULL,
    Phone VARCHAR(25) NULL,
    Active TINYINT NOT NULL,
    ManagerID INT NULL,
    StoreID INT NOT NULL,
    CONSTRAINT PK_DimStaff PRIMARY KEY(StaffKey)
);
GO

---------------------------------------------------------
-- DIM DATE
---------------------------------------------------------
CREATE TABLE dbo.DimDate(
    DateKey INT NOT NULL,
    FullDate DATE NOT NULL,
    Year INT NOT NULL,
    Quarter INT NOT NULL,
    Month INT NOT NULL,
    Day INT NOT NULL,
    Week INT NOT NULL,
    MonthName VARCHAR(20) NOT NULL,
    CONSTRAINT PK_DimDate PRIMARY KEY(DateKey)
);
GO

---------------------------------------------------------
-- DIM ORDERS 
---------------------------------------------------------
CREATE TABLE dbo.DimOrders(
    OrderKey INT IDENTITY(1,1) NOT NULL,
    OrderID INT NOT NULL,
    OrderStatus TINYINT NOT NULL,
    StoreID INT NOT NULL,
    StaffID INT NOT NULL,
    CONSTRAINT PK_DimOrders PRIMARY KEY(OrderKey)
);
GO

---------------------------------------------------------
-- HECHOS (FACT)
---------------------------------------------------------

CREATE TABLE dbo.FactSales(
    SalesKey INT IDENTITY(1,1) NOT NULL,

    -- FOREIGN KEYS
    CustomerKey INT NOT NULL,
    ProductKey INT NOT NULL,
    StoreKey INT NOT NULL,
    StaffKey INT NOT NULL,
    OrderKey INT NOT NULL,

    OrderDateKey INT NOT NULL,
    RequiredDateKey INT NOT NULL,
    ShippedDateKey INT NULL,

    -- MÉTRICAS
    Quantity INT NOT NULL,
    ListPrice DECIMAL(10,2) NOT NULL,
    Discount DECIMAL(4,2) NOT NULL,
    Total DECIMAL(12,2) NOT NULL,

    CONSTRAINT PK_FactSales PRIMARY KEY(SalesKey)
);
GO

---------------------------------------------------------
-- FOREIGN KEYS
---------------------------------------------------------

ALTER TABLE FactSales ADD CONSTRAINT FK_FactSales_Customer
FOREIGN KEY (CustomerKey) REFERENCES DimCustomers(CustomerKey);

ALTER TABLE FactSales ADD CONSTRAINT FK_FactSales_Product
FOREIGN KEY (ProductKey) REFERENCES DimProducts(ProductKey);

ALTER TABLE FactSales ADD CONSTRAINT FK_FactSales_Store
FOREIGN KEY (StoreKey) REFERENCES DimStores(StoreKey);

ALTER TABLE FactSales ADD CONSTRAINT FK_FactSales_Staff
FOREIGN KEY (StaffKey) REFERENCES DimStaffs(StaffKey);

ALTER TABLE FactSales ADD CONSTRAINT FK_FactSales_Order
FOREIGN KEY (OrderKey) REFERENCES DimOrders(OrderKey);

ALTER TABLE FactSales ADD CONSTRAINT FK_FactSales_OrderDate
FOREIGN KEY (OrderDateKey) REFERENCES DimDate(DateKey);

ALTER TABLE FactSales ADD CONSTRAINT FK_FactSales_RequiredDate
FOREIGN KEY (RequiredDateKey) REFERENCES DimDate(DateKey);

ALTER TABLE FactSales ADD CONSTRAINT FK_FactSales_ShippedDate
FOREIGN KEY (ShippedDateKey) REFERENCES DimDate(DateKey);

GO

SELECT * FROM DimCustomers;
SELECT * FROM DimProducts;
SELECT * FROM DimStores;
SELECT * FROM DimStaffs;
SELECT * FROM DimOrders;
SELECT COUNT(*) AS FactSalesCount FROM FactSales;
GO
