-- Databricks notebook source
-- MAGIC %md
-- MAGIC ## COUNT()

-- COMMAND ----------

SELECT COUNT(*) AS total_row_count FROM sql_masterclass.default.products

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## SUM()

-- COMMAND ----------

SELECT SUM(total_amount) FROM sql_masterclass.default.orders

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## MAX()

-- COMMAND ----------

SELECT MAX(total_amount) FROM sql_masterclass.default.orders

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## SubQuery Trailer

-- COMMAND ----------

SELECT * FROM sql_masterclass.default.orders
WHERE total_amount = (SELECT MAX(total_amount) FROM sql_masterclass.default.orders)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Arthmetic Operations + Aggregations

-- COMMAND ----------

SELECT  
    SUM(quantity * unit_price) AS total_amt,
    SUM((quantity * unit_price) - discount_amount) AS payable_amt
FROM sql_masterclass.default.orders

-- COMMAND ----------

SELECT * FROM sql_masterclass.default.orders
LIMIT 5

-- COMMAND ----------

SELECT customer_id, product_id, SUM(total_amount), count(*) FROM sql_masterclass.default.orders
GROUP BY 1, 2
ORDER BY 1

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## HAVING

-- COMMAND ----------

SELECT customer_id, SUM(total_amount) AS sum_amt FROM sql_masterclass.default.orders
-- WHERE sum_amt > 10000.00
GROUP BY 1
HAVING SUM(total_amount) > 10000.00

-- COMMAND ----------

