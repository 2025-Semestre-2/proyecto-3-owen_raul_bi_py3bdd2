---------------------------------------------------------
-- CREAR BASE DE DATOS
---------------------------------------------------------
CREATE DATABASE BikeStore_Stage;
GO

USE BikeStore_Stage;
GO

---------------------
-- TABLAS DE STAGING 
---------------------

-------------------------
-- STORES
-------------------------
CREATE TABLE [dbo].[stores](
    [store_id] INT NOT NULL,
    [store_name] VARCHAR(255) NOT NULL,
    [phone] VARCHAR(25) NULL,
    [email] VARCHAR(255) NULL,
    [street] VARCHAR(255) NULL,
    [city] VARCHAR(255) NULL,
    [state] VARCHAR(10) NULL,
    [zip_code] VARCHAR(5) NULL
);

-------------------------
-- STAFFS
-------------------------
CREATE TABLE [dbo].[staffs](
    [staff_id] INT NOT NULL,
    [first_name] VARCHAR(50) NOT NULL,
    [last_name] VARCHAR(50) NOT NULL,
    [email] VARCHAR(255) NOT NULL,
    [phone] VARCHAR(25) NULL,
    [active] TINYINT NOT NULL,
    [store_id] INT NOT NULL,
    [manager_id] INT NULL
);

-------------------------
-- CUSTOMERS
-------------------------
CREATE TABLE [dbo].[customers](
    [customer_id] INT NOT NULL,
    [first_name] VARCHAR(255) NOT NULL,
    [last_name] VARCHAR(255) NOT NULL,
    [phone] VARCHAR(25) NULL,
    [email] VARCHAR(255) NULL,
    [street] VARCHAR(255) NULL,
    [city] VARCHAR(50) NULL,
    [state] VARCHAR(25) NULL,
    [zip_code] VARCHAR(5) NULL
);

-------------------------
-- CATEGORIES
-------------------------
CREATE TABLE [dbo].[categories](
    [category_id] INT NOT NULL,
    [category_name] VARCHAR(255) NOT NULL
);

-------------------------
-- BRANDS
-------------------------
CREATE TABLE [dbo].[brands](
    [brand_id] INT NOT NULL,
    [brand_name] VARCHAR(255) NOT NULL
);

-------------------------
-- PRODUCTS
-------------------------
CREATE TABLE [dbo].[products](
    [product_id] INT NOT NULL,
    [product_name] VARCHAR(255) NOT NULL,
    [brand_id] INT NOT NULL,
    [category_id] INT NOT NULL,
    [model_year] SMALLINT NOT NULL,
    [list_price] DECIMAL(10,2) NOT NULL
);

-------------------------
-- ORDERS
-------------------------
CREATE TABLE [dbo].[orders](
    [order_id] INT NOT NULL,
    [customer_id] INT NOT NULL,
    [order_status] TINYINT NOT NULL,
    [order_date] DATE NOT NULL,
    [required_date] DATE NOT NULL,
    [shipped_date] DATE NULL,
    [store_id] INT NOT NULL,
    [staff_id] INT NOT NULL
);

-------------------------
-- ORDER ITEMS
-------------------------
CREATE TABLE [dbo].[order_items](
    [order_id] INT NOT NULL,
    [item_id] INT NOT NULL,
    [product_id] INT NOT NULL,
    [quantity] INT NOT NULL,
    [list_price] DECIMAL(10,2) NOT NULL,
    [discount] DECIMAL(4,2) NOT NULL
);

-------------------------
-- STOCKS
-------------------------
CREATE TABLE [dbo].[stocks](
    [store_id] INT NOT NULL,
    [product_id] INT NOT NULL,
    [quantity] INT NOT NULL
);

-- Verificación del BikeStore Stage
SELECT * FROM stores;
SELECT * FROM staffs;
SELECT * FROM customers;
SELECT * FROM categories;
SELECT * FROM brands;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM stocks;

-- Verificación del BikeStore original 
SELECT * FROM sales.stores;
SELECT * FROM sales.staffs;
SELECT * FROM sales.customers;
SELECT * FROM production.categories;
SELECT * FROM production.brands;
SELECT * FROM production.products;
SELECT * FROM sales.orders;
SELECT * FROM sales.order_items;
SELECT * FROM production.stocks;