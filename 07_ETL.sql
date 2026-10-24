-- Databricks notebook source
-- MAGIC %md
-- MAGIC ## Usecase
-- MAGIC _Total sales_ achived by each _Brand_. The sale confirmed vs pending orders. The data should be in Q1 2025.
-- MAGIC
-- MAGIC Final columns:
-- MAGIC - Brand
-- MAGIC - Total Confirmed Orders
-- MAGIC - Total Pending Orders
-- MAGIC - Total Confirmed Amount
-- MAGIC - Total Pending Amount

-- COMMAND ----------

CREATE OR REPLACE TABLE sql_masterclass.default.q1_sale_by_brand(
    brand STRING,
    total_confirmed_orders DECIMAL,
    total_pending_orders DECIMAL,
    total_confirmed_amount DECIMAL,
    total_pending_amount DECIMAL
)

-- COMMAND ----------

TRUNCATE TABLE sql_masterclass.default.q1_sale_by_brand

-- COMMAND ----------

INSERT INTO sql_masterclass.default.q1_sale_by_brand

WITH cte AS (
    SELECT 
        *
    FROM sql_masterclass.default.orders AS o
    LEFT JOIN sql_masterclass.default.products AS p
        ON o.product_id = p.product_id
    WHERE 
        EXTRACT(MONTH FROM order_date) IN (1, 2, 3) AND 
        EXTRACT(YEAR FROM order_date) = 2025
)

SELECT
    brand,
    SUM(CASE WHEN order_status = 'Delivered' THEN 1 ELSE 0 END) AS total_confirmed_orders,
    SUM(CASE WHEN order_status <> 'Delivered' THEN 1 ELSE 0 END) AS total_pending_orders,
    SUM(CASE WHEN order_status = 'Delivered' THEN total_amount ELSE 0 END) AS total_confirmed_amount,
    SUM(CASE WHEN order_status <> 'Delivered' THEN total_amount ELSE 0 END) AS total_pending_amount
FROM cte
GROUP BY 1

-- COMMAND ----------

SELECT * FROM sql_masterclass.default.q1_sale_by_brand
WHERE total_confirmed_orders > 0