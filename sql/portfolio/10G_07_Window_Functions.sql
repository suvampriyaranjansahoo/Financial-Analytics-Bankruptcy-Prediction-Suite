-- ==========================================================
-- File: 07G_07_Window_Functions.sql
-- Purpose: Analytical Window Functions
-- ==========================================================

SET search_path TO bankruptcy;

-- Rank companies by X1 within each year
SELECT
    company_name,
    year,
    X1,
    RANK() OVER(PARTITION BY year ORDER BY X1 DESC) AS rank_x1,
    DENSE_RANK() OVER(PARTITION BY year ORDER BY X1 DESC) AS dense_rank_x1
FROM company_financials;

-- Average X1 by year
SELECT
    company_name,
    year,
    X1,
    AVG(X1) OVER(PARTITION BY year) AS avg_x1_year
FROM company_financials;

-- Previous year's X1
SELECT
    company_name,
    year,
    X1,
    LAG(X1) OVER(PARTITION BY company_name ORDER BY year) AS previous_x1
FROM company_financials;

-- Next year's X1
SELECT
    company_name,
    year,
    X1,
    LEAD(X1) OVER(PARTITION BY company_name ORDER BY year) AS next_x1
FROM company_financials;

-- Running average
SELECT
    company_name,
    year,
    X1,
    AVG(X1) OVER(
        PARTITION BY company_name
        ORDER BY year
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_avg_x1
FROM company_financials;
