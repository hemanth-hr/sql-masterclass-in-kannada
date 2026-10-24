-- Databricks notebook source
-- MAGIC %md
-- MAGIC ## JOINS

-- COMMAND ----------

SELECT * FROM sql_masterclass.default.orders
LIMIT 5

-- COMMAND ----------

SELECT * FROM sql_masterclass.default.customers LIMIT 5

-- COMMAND ----------

SELECT 
    o.customer_id,
    first_name, 
    last_name,
    SUM(total_amount) AS total_amt
FROM sql_masterclass.default.orders AS o -- Possibility 1
LEFT JOIN sql_masterclass.default.customers c -- Possibility 2
ON o.customer_id = c.customer_id
GROUP BY 1, 2, 3

-- COMMAND ----------

SELECT 
    o.customer_id,
    concat(first_name, ' ', last_name) AS name, -- use only on STR columns
    SUM(total_amount) AS total_amt
FROM sql_masterclass.default.orders AS o -- Possibility 1
LEFT JOIN sql_masterclass.default.customers c -- Possibility 2
ON o.customer_id = c.customer_id
GROUP BY 1, 2

-- COMMAND ----------

SELECT 
    o.customer_id,
    first_name || ' ' || last_name AS name, -- use only on STR columns
    SUM(total_amount) AS total_amt
FROM sql_masterclass.default.orders AS o -- Possibility 1
LEFT JOIN sql_masterclass.default.customers c -- Possibility 2
ON o.customer_id = c.customer_id
GROUP BY 1, 2

-- COMMAND ----------

SELECT 
    o.customer_id,
    concat(first_name, ' ', last_name) AS name, -- use only on STR columns
    SUM(total_amount) AS total_amt
FROM sql_masterclass.default.customers c  -- Possibility 1
RIGHT JOIN sql_masterclass.default.orders AS o -- Possibility 2
ON o.customer_id = c.customer_id
GROUP BY 1, 2

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## COALESCE()

-- COMMAND ----------

SELECT * FROM sql_masterclass.default.customers LIMIT 3

-- COMMAND ----------

SELECT email FROM sql_masterclass.default.customers
WHERE email IS NOT NULL
-- WHERE email IS  NULL

-- COMMAND ----------

SELECT 
    coalesce(email, NULL, 'No email')
FROM sql_masterclass.default.customers