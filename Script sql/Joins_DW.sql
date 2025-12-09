---------------------------------------------------------
-- Lista de Joins para el Data Waregouse
---------------------------------------------------------

---------------------------------------------------------
-- Join para DimProducts
---------------------------------------------------------
SELECT 
	p.product_id, 
	p.product_name, 
	b.brand_id, 
	b.brand_name, 
	c.category_id, 
	c.category_name, 
	p.model_year, 
	p.list_price
FROM 
	DimProducts p
INNER JOIN 
	Dimcategories c ON p.category_id = c.category_id
INNER JOIN 
	brands b ON p.brand_id = b.brand_id

---------------------------------------------------------
-- Join para FactSales
---------------------------------------------------------
SELECT 
    -- LLAVES DE NEGOCIO
    o.order_id AS OrderID,
    o.customer_id AS CustomerID,
    o.store_id AS StoreID,
    o.staff_id AS StaffID,

    oi.product_id AS ProductID,

    -- FECHAS
    o.order_date AS OrderDate,
    o.required_date AS RequiredDate,
    ISNULL(o.shipped_date, '2015-01-01') AS ShippedDate,

    -- DETALLE DE LA ORDEN
    oi.quantity AS Quantity,
    oi.list_price AS OrderListPrice,
    oi.discount AS Discount,
    (oi.quantity * oi.list_price * (1 - oi.discount)) AS Total

FROM orders o
INNER JOIN order_items oi 
    ON o.order_id = oi.order_id
INNER JOIN products p 
    ON oi.product_id = p.product_id
INNER JOIN brands b 
    ON p.brand_id = b.brand_id
INNER JOIN categories c 
    ON p.category_id = c.category_id
INNER JOIN stores s 
    ON o.store_id = s.store_id
INNER JOIN customers cu 
    ON o.customer_id = cu.customer_id
INNER JOIN staffs st 
    ON o.staff_id = st.staff_id
ORDER BY o.order_id, oi.item_id;

SELECT * FROM FactSales