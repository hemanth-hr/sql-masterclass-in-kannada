-- Databricks notebook source
-- MAGIC %md
-- MAGIC ## ROW_NUMBER()

-- COMMAND ----------

WITH dup AS (
    (SELECT * FROM sql_masterclass.default.products 
    LIMIT 5)
    UNION ALL
    SELECT 101, 'Wireless Mousse', 'Electronics', 'Logitech', 799.00, '2023-06-01'
)

SELECT * FROM dup

-- COMMAND ----------

WITH dup AS (
    (SELECT * FROM sql_masterclass.default.products 
    LIMIT 5)
    UNION ALL
    SELECT 101, 'Wireless Mousse', 'Electronics', 'Logitech', 799.00, '2023-06-01'
),

rn_dup AS (
SELECT 
    *,
    ROW_NUMBER() OVER(PARTITION BY product_id ORDER BY product_id) AS rn
FROM dup)

SELECT * EXCEPT (rn) FROM rn_dup
WHERE rn = 1;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## DENSE_RANK() and RANK()

-- COMMAND ----------

UPDATE sql_masterclass.default.customers
SET signup_date = '2024-01-15'
WHERE customer_id = 1007;

-- COMMAND ----------

SELECT * FROM sql_masterclass.default.customers LIMIT 5

-- COMMAND ----------

SELECT 
    customer_id, signup_date,
    ROW_NUMBER() OVER(ORDER BY signup_date) AS rn,
    RANK() OVER(ORDER BY signup_date) AS rk,
    DENSE_RANK() OVER(ORDER BY signup_date) AS drk
FROM sql_masterclass.default.customers

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## LAG()

-- COMMAND ----------

SELECT order_date, total_amount FROM sql_masterclass.default.orders

-- COMMAND ----------

WITH cte AS (
SELECT 
    order_date, total_amount,
    LAG(total_amount, 1, 1) OVER(ORDER BY order_date) AS prev_day_amt
FROM sql_masterclass.default.orders
)
SELECT *,
    ROUND(100.0 * ((total_amount-prev_day_amt)/prev_day_amt), 2) AS pct_change
FROM cte

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## SUM()

-- COMMAND ----------

-- MAGIC %md
-- MAGIC *Cumulative sum*

-- COMMAND ----------

SELECT SUM(total_amount) FROM sql_masterclass.default.orders

-- COMMAND ----------

SELECT order_date, total_amount,
    SUM(total_amount) OVER() AS total,
    SUM(total_amount) OVER(ORDER BY order_date) AS cum_sum,
    SUM(total_amount) OVER (ORDER BY order_date ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) AS rolling_3d
FROM sql_masterclass.default.orders

-- COMMAND ----------

