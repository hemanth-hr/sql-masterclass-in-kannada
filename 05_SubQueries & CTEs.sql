-- Databricks notebook source
-- MAGIC %md
-- MAGIC ## Sub Query

-- COMMAND ----------

SELECT COUNT(DISTINCT customer_id) 
FROM (
    SELECT * FROM sql_masterclass.default.orders
    WHERE customer_id IN (1001, 1002)
) temp

-- COMMAND ----------

SELECT avg(total_amount) FROM sql_masterclass.default.orders

-- COMMAND ----------

SELECT * FROM sql_masterclass.default.orders
WHERE total_amount > (SELECT AVG(total_amount) FROM sql_masterclass.default.orders)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## CTE

-- COMMAND ----------

SELECT * FROM sql_masterclass.default.orders LIMIT 5

-- COMMAND ----------

WITH cte AS (
    SELECT
        customer_id,
        SUM(total_amount) AS amt
    FROM sql_masterclass.default.orders
    GROUP BY 1
)

SELECT * FROM cte
WHERE amt > (SELECT AVG(amt) FROM cte)

-- COMMAND ----------

WITH cust_level AS (
    SELECT
        customer_id,
        SUM(total_amount) AS amt
    FROM sql_masterclass.default.orders
    GROUP BY 1
),
avg_ord AS (
    SELECT AVG(total_amount) AS av
    FROM sql_masterclass.default.orders
)

SELECT * FROM cust_level
WHERE amt > (SELECT * FROM avg_ord)