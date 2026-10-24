-- Databricks notebook source
DROP CATALOG IF EXISTS sql_masterclass CASCADE;

-- COMMAND ----------

CREATE CATALOG sql_masterclass

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Customers

-- COMMAND ----------

CREATE TABLE sql_masterclass.default.customers (
    customer_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE,
    customer_tier VARCHAR(20)      -- Bronze / Silver / Gold
);

-- COMMAND ----------

INSERT INTO sql_masterclass.default.customers (customer_id, first_name, last_name, email, city, state, signup_date, customer_tier) VALUES
(1001, 'Ananya',  'Rao',      'ananya.rao@example.com',      'Bengaluru', 'Karnataka',   DATE '2024-01-15', 'Gold'),
(1002, 'Rohit',   'Sharma',   'rohit.sharma@example.com',    'Mumbai',    'Maharashtra', DATE '2024-02-10', 'Silver'),
(1003, 'Priya',   'Nair',     'priya.nair@example.com',      'Kochi',     'Kerala',      DATE '2024-03-05', 'Gold'),
(1004, 'Arjun',   'Gowda',    'arjun.gowda@example.com',     'Mysuru',    'Karnataka',   DATE '2024-03-22', 'Bronze'),
(1005, 'Sneha',   'Kulkarni', 'sneha.kulkarni@example.com',  'Hubballi',  'Karnataka',   DATE '2024-04-18', 'Silver'),
(1006, 'Vikram',  'Singh',    'vikram.singh@example.com',    'Delhi',     'Delhi',       DATE '2024-05-02', 'Bronze'),
(1007, 'Meera',   'Iyer',     'meera.iyer@example.com',      'Chennai',   'Tamil Nadu',  DATE '2024-05-27', 'Gold'),
(1008, 'Karthik', 'Shetty',   'karthik.shetty@example.com',  'Mangaluru', 'Karnataka',   DATE '2024-06-14', 'Silver'),
(1009, 'Divya',   'Reddy',    'divya.reddy@example.com',     'hyderabad', 'Telangana',   DATE '2024-07-01', 'Bronze'),  -- lowercase city (cleaning demo)
(1010, 'Suresh',  'Patil',    'suresh.patil@example.com',    'Pune',      'Maharashtra', DATE '2024-07-19', 'Bronze'),
(1011, 'Neha',    'Gupta',    'neha.gupta@example.com',      'Jaipur',    'Rajasthan',   DATE '2024-08-08', 'Silver'),
(1012, 'Rahul',   'Hegde',    NULL,                          'Bengaluru', 'Karnataka',   DATE '2024-09-12', 'Bronze'),  -- NULL email (NULL handling demo)
(1013, 'Lakshmi', 'Bhat',     'lakshmi.bhat@example.com',    'Udupi',     'Karnataka',   DATE '2024-10-03', 'Silver'),
(1014, 'Aditya',  'Verma',    'aditya.verma@example.com',    'Kolkata',   'West Bengal', DATE '2024-11-21', 'Bronze'),  -- no orders (LEFT JOIN / anti-join demo)
(1015, 'Pooja',   'Desai',    'pooja.desai@example.com',     'Belagavi',  'Karnataka',   DATE '2024-12-09', 'Bronze');  -- no orders

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Products

-- COMMAND ----------

CREATE TABLE sql_masterclass.default.products (
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    brand VARCHAR(50),
    unit_price DECIMAL(10,2),
    created_date DATE
);

-- COMMAND ----------

INSERT INTO sql_masterclass.default.products (product_id, product_name, category, brand, unit_price, created_date) VALUES
(101, 'Wireless Mouse',              'Electronics', 'Logitech',  799.00,   DATE '2023-06-01'),
(102, 'Mechanical Keyboard',         'Electronics', 'Redragon',  3499.00,  DATE '2023-06-01'),
(103, 'USB-C Hub',                   'Electronics', 'Anker',     2199.00,  DATE '2023-07-15'),
(104, 'Noise Cancelling Headphones', 'Electronics', 'Sony',      12999.00, DATE '2023-08-10'),
(105, 'Running Shoes',               'Footwear',    'Nike',      5499.00,  DATE '2023-09-01'),
(106, 'Casual Sneakers',             'Footwear',    'Puma',      3299.00,  DATE '2023-09-01'),
(107, 'Cotton T-Shirt',              'Apparel',     'Levis',     999.00,   DATE '2023-10-05'),
(108, 'Denim Jacket',                'Apparel',     'Levis',     3999.00,  DATE '2023-10-05'),
(109, 'Stainless Steel Bottle',      'Home',        'Milton',    649.00,   DATE '2023-11-20'),
(110, 'Office Chair',                'Furniture',   'Godrej',    8999.00,  DATE '2023-12-01'),
(111, 'Desk Lamp',                   'Home',        'Philips',   1299.00,  DATE '2024-01-10'),
(112, 'Yoga Mat',                    'Sports',      'Decathlon', 899.00,   DATE '2024-02-01');  -- never ordered (anti-join demo)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Orders

-- COMMAND ----------

CREATE TABLE sql_masterclass.default.orders (
    order_id INT,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    unit_price DECIMAL(10,2),   -- price at time of order
    discount_amount DECIMAL(10,2),
    total_amount DECIMAL(12,2),
    order_status VARCHAR(20),     -- Delivered / Shipped / Cancelled / Returned
    payment_method VARCHAR(20)      -- UPI / Credit Card / Debit Card / COD / Net Banking
);

-- COMMAND ----------

INSERT INTO sql_masterclass.default.orders (order_id, customer_id, product_id, order_date, quantity, unit_price, discount_amount, total_amount, order_status, payment_method) VALUES
(5001, 1001, 101, DATE '2025-01-05', 1, 799.00,    0.00,    799.00,   'Delivered', 'UPI'),
(5002, 1001, 104, DATE '2025-01-20', 1, 12999.00,  1000.00, 11999.00, 'Delivered', 'Credit Card'),
(5003, 1002, 105, DATE '2025-01-12', 1, 5499.00,   0.00,    5499.00,  'Delivered', 'Debit Card'),
(5004, 1003, 107, DATE '2025-01-25', 3, 999.00,    300.00,  2697.00,  'Delivered', 'UPI'),
(5005, 1004, 109, DATE '2025-02-02', 2, 649.00,    0.00,    1298.00,  'Delivered', 'COD'),
(5006, 1005, 102, DATE '2025-02-08', 1, 3499.00,   200.00,  3299.00,  'Delivered', 'UPI'),
(5007, 1001, 103, DATE '2025-02-14', 1, 2199.00,   0.00,    2199.00,  'Delivered', 'Credit Card'),
(5008, 1006, 110, DATE '2025-02-18', 1, 8999.00,   500.00,  8499.00,  'Cancelled', 'Net Banking'),
(5009, 1007, 108, DATE '2025-02-21', 1, 3999.00,   0.00,    3999.00,  'Delivered', 'UPI'),
(5010, 1003, 111, DATE '2025-03-01', 2, 1299.00,   100.00,  2498.00,  'Delivered', 'Credit Card'),
(5011, 1008, 106, DATE '2025-03-04', 1, 3299.00,   0.00,    3299.00,  'Returned',  'Debit Card'),
(5012, 1002, 101, DATE '2025-03-09', 2, 799.00,    0.00,    1598.00,  'Delivered', 'UPI'),
(5013, 1009, 107, DATE '2025-03-15', 2, 999.00,    0.00,    1998.00,  'Delivered', 'COD'),
(5014, 1010, 105, DATE '2025-03-20', 1, 5499.00,   500.00,  4999.00,  'Delivered', 'Credit Card'),
(5015, 1001, 109, DATE '2025-03-28', 1, 649.00,    0.00,    649.00,   'Delivered', 'UPI'),
(5016, 1011, 104, DATE '2025-04-02', 1, 12999.00,  0.00,    12999.00, 'Delivered', 'Credit Card'),
(5017, 1007, 102, DATE '2025-04-07', 1, 3499.00,   0.00,    3499.00,  'Delivered', 'UPI'),
(5018, 1012, 108, DATE '2025-04-11', 1, 3999.00,   400.00,  3599.00,  'Delivered', 'Debit Card'),
(5019, 1005, 111, DATE '2025-04-15', 1, 1299.00,   0.00,    1299.00,  'Delivered', 'UPI'),
(5020, 1013, 103, DATE '2025-04-19', 2, 2199.00,   200.00,  4198.00,  'Delivered', 'Net Banking'),
(5021, 1003, 104, DATE '2025-04-24', 1, 12999.00,  1500.00, 11499.00, 'Delivered', 'Credit Card'),
(5022, 1004, 110, DATE '2025-05-03', 1, 8999.00,   0.00,    8999.00,  'Shipped',   'COD'),
(5023, 1008, 101, DATE '2025-05-06', 3, 799.00,    0.00,    2397.00,  'Delivered', 'UPI'),
(5024, 1002, 106, DATE '2025-05-12', 1, 3299.00,   300.00,  2999.00,  'Delivered', 'Debit Card'),
(5025, 1006, 107, DATE '2025-05-16', 4, 999.00,    400.00,  3596.00,  'Delivered', 'COD'),
(5026, 1001, 105, DATE '2025-05-21', 1, 5499.00,   0.00,    5499.00,  'Delivered', 'UPI'),
(5027, 1009, 109, DATE '2025-05-27', 2, 649.00,    0.00,    1298.00,  'Cancelled', 'UPI'),
(5028, 1007, 111, DATE '2025-06-02', 1, 1299.00,   0.00,    1299.00,  'Delivered', 'Credit Card'),
(5029, 1013, 102, DATE '2025-06-08', 1, 3499.00,   0.00,    3499.00,  'Shipped',   'UPI'),
(5030, 1010, 108, DATE '2025-06-14', 1, 3999.00,   0.00,    3999.00,  'Delivered', 'Net Banking');

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Check for data

-- COMMAND ----------

SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM sql_masterclass.default.customers
UNION ALL 
SELECT 'products', COUNT(*) FROM sql_masterclass.default.products
UNION ALL 
SELECT 'orders',   COUNT(*) FROM sql_masterclass.default.orders;

-- COMMAND ----------

