                              #SalesOrders-Project

#  CREATE DATABASE
Create database SalesOrders ;
Use SalesOrders ;

# RAW TABLE (This table stores original unprocessed data)
CREATE TABLE sales_raw (
    order_id VARCHAR(20),
    customer_name VARCHAR(150),
    product_category VARCHAR(100),
    product_name VARCHAR(150),
    quantity INT,
    unit_price DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(100),
    salesperson VARCHAR(100),
    total_sales DECIMAL(10,2)
);
 # Dimension Tables
 
#Customers Table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(200) NOT NULL
);

#Products Table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(150),
    category VARCHAR(100),
    unit_price DECIMAL(10,2)
);

#Salespersons Table
CREATE TABLE salespersons (
    salesperson_id INT AUTO_INCREMENT PRIMARY KEY,
    salesperson_name VARCHAR(100),
    region VARCHAR(100)
);

#Orders Table (Contain foreign keys linking dimensions)
CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id INT,
    product_id INT,
    salesperson_id INT,
    quantity INT,
    order_date DATE,
    total_sales DECIMAL(10,2),

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (salesperson_id) REFERENCES salespersons(salesperson_id)
);

# LOAD DIMENSION TABLES (Insert unique records from raw table)
INSERT INTO customers (customer_name)
SELECT DISTINCT customer_name
FROM sales_raw;


INSERT INTO products (product_name, category, unit_price)
SELECT DISTINCT product_name, product_category, unit_price
FROM sales_raw;

INSERT INTO salespersons (salesperson_name, region)
SELECT DISTINCT salesperson, region
FROM sales_raw;

#Using JOIN to get foreign keys ON DUPLICATE KEY ensures no primary key error
INSERT INTO orders (
    order_id,
    customer_id,
    product_id,
    salesperson_id,
    quantity,
    order_date,
    total_sales
)
SELECT 
    r.order_id,
    c.customer_id,
    p.product_id,
    s.salesperson_id,
    r.quantity,
    r.order_date,
    r.total_sales
FROM sales_raw r
JOIN customers c 
    ON r.customer_name = c.customer_name
JOIN products p 
    ON r.product_name = p.product_name
JOIN salespersons s 
    ON r.salesperson = s.salesperson_name
ON DUPLICATE KEY UPDATE
    customer_id = VALUES(customer_id),
    product_id = VALUES(product_id),
    salesperson_id = VALUES(salesperson_id),
    quantity = VALUES(quantity),
    order_date = VALUES(order_date),
    total_sales = VALUES(total_sales);
    
    #DATA VALIDATION QUERIES
    #Check Final Data
    SELECT COUNT(*) FROM orders;
    
    # View Sample Data
    SELECT * FROM orders
LIMIT 10;

#Check Foreign Key Relationships
SELECT o.order_id, c.customer_name, p.product_name, s.salesperson_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
JOIN salespersons s ON o.salesperson_id = s.salesperson_id
LIMIT 10;

#BUSINESS REPORTS / ANALYTICS

# Total Sales by Product:
SELECT p.product_name, SUM(o.total_sales) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name;

#Total Sales by Salesperson:
SELECT s.salesperson_name, SUM(o.total_sales) AS total_sales
FROM orders o
JOIN salespersons s ON o.salesperson_id = s.salesperson_id
GROUP BY s.salesperson_name;

#Total Sales by Customer:
SELECT c.customer_name, SUM(o.total_sales) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_name;

  #Top 5 Best Selling Products
  SELECT p.product_name,
       SUM(o.quantity) AS total_quantity
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
LIMIT 5;

 #Monthly Sales Trend
 SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(total_sales) AS monthly_sales
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

#Region-wise Sales
SELECT s.region,
       SUM(o.total_sales) AS total_sales
FROM orders o
JOIN salespersons s ON o.salesperson_id = s.salesperson_id
GROUP BY s.region;