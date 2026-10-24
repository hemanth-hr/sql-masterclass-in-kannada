-- Databricks notebook source
-- MAGIC %md
-- MAGIC ## SELECT

-- COMMAND ----------

SELECT 'Hemanth' AS name

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## FROM

-- COMMAND ----------

SELECT category, brand FROM sql_masterclass.default.products

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## DISTINCT

-- COMMAND ----------

SELECT DISTINCT category FROM sql_masterclass.default.products

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## WHERE

-- COMMAND ----------

SELECT * FROM sql_masterclass.default.products
WHERE product_id IN (101, 102, 106)

-- COMMAND ----------

SELECT * FROM sql_masterclass.default.products
WHERE unit_price > 1500.00 AND unit_price < 5000.00

-- COMMAND ----------

SELECT * FROM sql_masterclass.default.products
WHERE category = 'Electronics' OR category = 'Footwear'

-- COMMAND ----------

SELECT * FROM sql_masterclass.default.products
WHERE category LIKE '_l%'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## ORDER BY

-- COMMAND ----------

SELECT created_date, unit_price FROM sql_masterclass.default.products
ORDER BY 2 DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## LIMIT

-- COMMAND ----------

SELECT unit_price FROM sql_masterclass.default.products
ORDER BY 1
LIMIT 3

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## CASE WHEN 

-- COMMAND ----------

SELECT *,
CASE 
    WHEN unit_price > 5000.00 THEN 'Costly'
    WHEN unit_price > 1500.00 AND unit_price <= 5000.00 THEN 'Medium'
    ELSE 'Affordable'
END AS price_category
FROM sql_masterclass.default.products

-- COMMAND ----------

SELECT *,
CASE 
    WHEN email IS NULL THEN 0
    ELSE 1
END AS email_flg
FROM sql_masterclass.default.customers