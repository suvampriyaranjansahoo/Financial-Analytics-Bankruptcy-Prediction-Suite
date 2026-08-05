-- ==========================================================
-- Project  : Bankruptcy Risk Prediction Platform
-- Module   : SQL Analytics
-- File     : 07K_11_SQL_Interview_Portfolio.sql
-- Database : PostgreSQL
-- Author   : Suvam Priyaranjan Sahoo
-- Purpose  : SQL interview practice using the Bankruptcy dataset.
-- ==========================================================

SET search_path TO bankruptcy;

-- Q1: Total companies
SELECT COUNT(*) AS total_companies
FROM company_financials;

-- Q2: Status distribution
SELECT status_label, COUNT(*)
FROM company_financials
GROUP BY status_label;

-- Q3: Average X1 by year
SELECT year, AVG(X1) AS avg_x1
FROM company_financials
GROUP BY year
ORDER BY year;

-- Q4: Top 5 companies by X1
SELECT company_name, year, X1
FROM company_financials
ORDER BY X1 DESC
LIMIT 5;

-- Q5: Companies above yearly average (CTE)
WITH yearly_avg AS (
  SELECT year, AVG(X1) avg_x1
  FROM company_financials
  GROUP BY year
)
SELECT c.company_name,c.year,c.X1
FROM company_financials c
JOIN yearly_avg y ON c.year=y.year
WHERE c.X1>y.avg_x1;

-- Q6: Rank companies by X1
SELECT company_name,year,X1,
RANK() OVER(PARTITION BY year ORDER BY X1 DESC) AS rank_x1
FROM company_financials;

-- Q7: Running average
SELECT company_name,year,
AVG(X1) OVER(PARTITION BY company_name ORDER BY year
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_avg
FROM company_financials;

-- Q8: Previous year's X1
SELECT company_name,year,X1,
LAG(X1) OVER(PARTITION BY company_name ORDER BY year) AS prev_x1
FROM company_financials;

-- Q9: Query dashboard view
SELECT * FROM vw_yearly_summary;

-- Q10: Call reusable function
SELECT fn_bankruptcy_rate();
