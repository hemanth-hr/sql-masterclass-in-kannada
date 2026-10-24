-- Databricks notebook source
CREATE SCHEMA sql_masterclass.test

-- COMMAND ----------

CREATE TABLE sql_masterclass.test.test_table (
    c1 INT,
    c2 STRING
)

-- COMMAND ----------

INSERT INTO sql_masterclass.test.test_table (c1)
VALUES (2)

-- COMMAND ----------

UPDATE sql_masterclass.test.test_table
SET c2 = '1234'
WHERE c1 = 2

-- COMMAND ----------

SELECT * FROM sql_masterclass.test.test_table

-- COMMAND ----------

ALTER TABLE sql_masterclass.test.test_table
ADD COLUMN c3 BOOLEAN;

-- COMMAND ----------

SELECT * FROM sql_masterclass.test.test_table

-- COMMAND ----------

DELETE FROM sql_masterclass.test.test_table
WHERE c1 = 1


-- COMMAND ----------

DROP SCHEMA sql_masterclass.test