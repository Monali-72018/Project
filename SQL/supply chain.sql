CREATE DATABASE supply_chain;

USE supply_chain;

SELECT * FROM Inventory;

SHOW COLUMNS FROM Inventory;

ALTER TABLE Inventory
RENAME COLUMN `Product type` TO product_type,
RENAME COLUMN `Revenue generated` TO revenue_generated,
RENAME COLUMN `Customer demographics` TO customer_demographics,
RENAME COLUMN `Stock levels` TO stock_levels,
RENAME COLUMN `Order quantities` TO order_quantities,
RENAME COLUMN `Shipping times` TO shipping_times,
RENAME COLUMN `Shipping carriers` TO shipping_carriers,
RENAME COLUMN `Shipping costs` TO shipping_costs,
RENAME COLUMN `Supplier name` TO supplier_name;

ALTER TABLE Inventory
RENAME COLUMN `Number of products sold` TO quantity_sold;

-- Total Inventory

SELECT 
    SUM(stock_levels) AS Total_Inventory
FROM Inventory;

-- Total Revenue

SELECT 
    SUM(revenue_generated) AS Total_Revenue
FROM Inventory;

-- Average Stock Level

SELECT 
    AVG(stock_levels) AS Avg_Stock
FROM Inventory;

-- Top 10 Products by Revenue

SELECT 
    SKU,
    SUM(revenue_generated) AS Revenue
FROM Inventory
GROUP BY SKU
ORDER BY Revenue DESC
LIMIT 10;

-- Top Selling Products 

SELECT product_type,
       SUM(quantity_sold) AS total_sales
FROM Inventory
GROUP BY product_type
ORDER BY total_sales DESC
LIMIT 10;

-- Low Stock Products

SELECT 
    SKU,
    stock_levels
FROM Inventory
WHERE stock_levels < 50;

-- Supplier-wise Revenue

SELECT 
    supplier_name,
    SUM(revenue_generated) AS Revenue
FROM Inventory
GROUP BY supplier_name
ORDER BY Revenue DESC;

-- Product type wise Sales

SELECT Product_type,
       SUM(quantity_sold) AS sales
FROM Inventory
GROUP BY Product_type;

-- Top 5 Suppliers by Quantity Sold

SELECT
    supplier_name,
    SUM(quantity_sold) AS total_quantity
FROM Inventory
GROUP BY supplier_name
ORDER BY total_quantity DESC
LIMIT 5;

-- Average Shipping Cost by Carrier

SELECT
    shipping_carriers,
    ROUND(AVG(shipping_costs),2) AS avg_shipping_cost
FROM Inventory
GROUP BY shipping_carriers
ORDER BY avg_shipping_cost DESC;

-- Product Type wise Revenue

SELECT
    Product_type,
    SUM(revenue_generated) AS revenue
FROM Inventory
GROUP BY Product_type
ORDER BY revenue DESC;

-- Products with Highest Revenue

SELECT
    SKU,
    product_type,
    revenue_generated
FROM Inventory
ORDER BY revenue_generated DESC
LIMIT 10;

-- Supplier Performance

SELECT
    supplier_name,
    COUNT(*) AS products_supplied,
    SUM(revenue_generated) AS total_revenue
FROM Inventory
GROUP BY supplier_name
ORDER BY total_revenue DESC;

-- Average Shipping Time

SELECT
    ROUND(AVG(shipping_times),2) AS avg_shipping_time
FROM Inventory;

-- Revenue by Customer Demographics

SELECT
    customer_demographics,
    SUM(revenue_generated) AS revenue
FROM Inventory
GROUP BY customer_demographics
ORDER BY revenue DESC;

-- High Revenue + Low Stock Products

SELECT
    SKU,
    product_type,
    revenue_generated,
    stock_levels
FROM Inventory
WHERE stock_levels < 50
ORDER BY revenue_generated DESC;

-- Revenue Contribution %

SELECT
    category,
    ROUND(
        SUM(revenue_generated) * 100 /
        (SELECT SUM(revenue_generated) FROM Inventory),
        2
    ) AS revenue_percent
FROM Inventory
GROUP BY category;