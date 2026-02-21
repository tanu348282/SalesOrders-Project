# 📊 Sales Orders Data Warehouse Project

## 📌 Project Overview
This project is a Sales Data Warehouse system built using MySQL.
It follows a Star Schema design with:

- Raw Staging Table
- Dimension Tables
  - Customers
  - Products
  - Salespersons
- Fact Table
  - Orders
 
    
The project demonstrates data cleaning, transformation, and business analysis using SQL.


##  Technologies Used
- MySQL
- SQL (DDL & DML)
- Database Design (Star Schema)



## 📂 Database Structure

### 1️⃣ sales_raw (Staging Table)
Stores original raw data before transformation.

### 2️⃣ customers (Dimension Table)
Stores unique customer records.

### 3️⃣ products (Dimension Table)
Stores product details including category and price.

 ### 4️⃣ salespersons (Dimension Table)
Stores salesperson information and region.

### 5️⃣ orders (Fact Table)
Contains transactional data with foreign key relationships.

---

## 🔄 Data Processing
- Used DISTINCT to remove duplicates.
- Used JOIN operations to connect dimension tables.
- Used ON DUPLICATE KEY UPDATE to handle duplicate records.
- Implemented foreign key constraints for data integrity.



## 📊 Business Analysis Queries

The project includes reports such as:

- Total Sales by Product
- Total Sales by Salesperson
- Total Sales by Customer
- Top 5 Best-Selling Products
- Monthly Sales Trend
- Region-wise Sales Analysis



## 🎯 Purpose of Project
This project demonstrates:
- ETL process
-  Database normalization
- Data warehouse design
- Business reporting using SQL

  ## 📸 Output Screenshots

### 🗄 Database Creation
![Database](images/create_and_use_database.png)

### 📊 Total Sales by Salesperson
![Salesperson](images/total_sales_by_salesperson.png)

### 📈 Monthly Sales Trend
![Monthly Trend](images/monthly_sales_trend.png)

### 🏆 Top 5 Best Selling Products
![Top Products](images/top_5_best_selling_products.png)

  ## Author
  TANISHKA CHAWLA

