-- ==========================================================
-- File: 07H_08_CTEs_and_Subqueries.sql
-- Purpose: Advanced SQL using CTEs and Subqueries
-- Database: PostgreSQL
-- ==========================================================

SET search_path TO bankruptcy;

-- ==========================================
-- CTE 1: Average X1 by Year
-- ==========================================
WITH yearly_avg AS (
    SELECT
        year,
        AVG(X1) AS avg_x1
    FROM company_financials
    GROUP BY year
)
SELECT *
FROM yearly_avg
ORDER BY avg_x1 DESC;

-- ==========================================
-- CTE 2: Companies Above Yearly Average
-- ==========================================
WITH yearly_avg AS (
    SELECT
        year,
        AVG(X1) AS avg_x1
    FROM company_financials
    GROUP BY year
)
SELECT
    c.company_name,
    c.year,
    c.X1
FROM company_financials c
JOIN yearly_avg y
ON c.year = y.year
WHERE c.X1 > y.avg_x1
ORDER BY c.year, c.X1 DESC;

-- ==========================================
-- Subquery 1: Top 10 X1 Companies
-- ==========================================
SELECT *
FROM (
    SELECT
        company_name,
        year,
        X1
    FROM company_financials
    ORDER BY X1 DESC
    LIMIT 10
) top_companies;

-- ==========================================
-- Correlated Subquery
-- ==========================================
SELECT
    company_name,
    year,
    X1
FROM company_financials c
WHERE X1 >
(
    SELECT AVG(X1)
    FROM company_financials
    WHERE year = c.year
);

-- ==========================================
-- Nested Subquery
-- ==========================================
SELECT *
FROM company_financials
WHERE company_name IN
(
    SELECT company_name
    FROM company_financials
    WHERE status_label = 'alive'
);
